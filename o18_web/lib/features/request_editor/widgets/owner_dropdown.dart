// ignore_for_file: must_be_immutable

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_web/theme/theme.dart';
import 'package:o18_web/utils/utils.dart';

class OwnerDropdown extends StatefulWidget {
  final List<Owner> list;
  final Owner? owner;
  final Function(Owner?) onChanged;
  final double width;
  final bool enabled;
  String? Function(Owner?)? validator;

  OwnerDropdown({
    required this.list,
    required this.onChanged,
    this.width = 430,
    this.owner,
    this.enabled = true,
    this.validator,
  });

  @override
  State<OwnerDropdown> createState() => _OwnerDropdownState();
}

class _OwnerDropdownState extends State<OwnerDropdown> {
  Owner? owner;

  @override
  void initState() {
    if (widget.owner != null) {
      owner = widget.owner;
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
            RequestEditorString.owner,
            style: AppFonts.commonText,
          ),
          SizedBox(height: 8.h),
          DropdownButtonHideUnderline(
            child: DropdownButtonFormField2(
              validator: widget.validator,
              hint: Text(
                RequestEditorString.selectFromList,
                style: AppFonts.dropDownGrey,
              ),
              menuItemStyleData: MenuItemStyleData(
                height: 35.h,
                padding: EdgeInsets.only(left: 28.w),
              ),
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              buttonStyleData: ButtonStyleData(
                width: widget.width.w,
                height: 56.h,
                padding: EdgeInsets.only(left: 28.w),
                decoration: BoxDecoration(
                  color: AppColors.grey_3,
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 6.h),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.r),
                  ),
                ),
                errorStyle: const TextStyle(fontSize: 0.01),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.red),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.r),
                  ),
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
                    (o) => DropdownMenuItem(
                      value: o,
                      child: Text(
                        '${o.name}',
                        style: widget.enabled ? AppFonts.dropDownBlack : AppFonts.dropDownGrey,
                      ),
                    ),
                  )
                  .toList(),
              value: owner,
              onChanged: widget.enabled
                  ? (val) {
                      widget.onChanged(val! as Owner);
                      setState(() {
                        owner = val as Owner;
                      });
                    }
                  : null,
            ),
          ),
        ],
      );
}
