import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:model_repository/model_repository.dart';

import 'package:o18_web/theme/theme.dart';
import 'package:o18_web/utils/utils.dart';

class StaffDropdown extends StatefulWidget {
  final String title;
  final List<Staff> list;
  final Staff? staff;
  final Function(Staff?) onChanged;
  final double width;
  final bool enabled;

  const StaffDropdown({
    required this.title,
    required this.list,
    required this.onChanged,
    this.width = 430,
    this.staff,
    this.enabled = true,
  });

  @override
  State<StaffDropdown> createState() => _StaffDropdownState();
}

class _StaffDropdownState extends State<StaffDropdown> {
  Staff? staff;

  @override
  void initState() {
    if (widget.staff != null) {
      staff = widget.staff;
    }
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: AppFonts.commonText,
          ),
          SizedBox(height: 8.h),
          DropdownButtonHideUnderline(
            child: DropdownButton2<Staff>(
              hint: Text(
                RequestEditorString.selectFromList,
                style: AppFonts.dropDownGrey,
              ),
              buttonStyleData: ButtonStyleData(
                padding: EdgeInsets.only(left: 28.w),
                width: widget.width.w,
                height: 56.h,
                decoration: BoxDecoration(
                  color: AppColors.grey_3,
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              menuItemStyleData: MenuItemStyleData(
                height: 35.h,
                padding: EdgeInsets.only(
                  left: 28.w,
                ),
              ),
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              iconStyleData: IconStyleData(
                icon: widget.enabled
                    ? Padding(
                        padding: EdgeInsets.only(right: 14.w),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          size: 20.w,
                          color: AppColors.green_0,
                        ),
                      )
                    : const SizedBox(),
              ),
              items: widget.list
                  .map(
                    (s) => DropdownMenuItem(
                      value: s,
                      child: Text(
                        '${s.name!} - ${s.position}',
                        style: widget.enabled ? AppFonts.dropDownBlack : AppFonts.dropDownGrey,
                      ),
                    ),
                  )
                  .toList(),
              value: staff,
              onChanged: widget.enabled
                  ? (val) {
                      widget.onChanged(val);
                      setState(() {
                        staff = val;
                      });
                    }
                  : null,
            ),
          ),
        ],
      );
}
