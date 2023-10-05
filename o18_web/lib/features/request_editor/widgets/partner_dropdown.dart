import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_web/theme/theme.dart';
import 'package:o18_web/utils/utils.dart';

class PartnerDropdown extends StatefulWidget {
  final String title;
  final List<Partner> list;
  final Partner? partner;
  final Function(Partner?) onChanged;
  final double width;
  final bool enabled;

  const PartnerDropdown({
    required this.title,
    required this.list,
    required this.onChanged,
    this.width = 430,
    this.partner,
    this.enabled = true,
  });

  @override
  State<PartnerDropdown> createState() => _PartnerDropdownState();
}

class _PartnerDropdownState extends State<PartnerDropdown> {
  Partner? partner;

  @override
  void initState() {
    if (widget.partner != null) {
      partner = widget.partner;
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
            child: DropdownButton2<Partner>(
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
                    (p) => DropdownMenuItem(
                      value: p,
                      child: Text(
                        p.title!,
                        style: widget.enabled ? AppFonts.dropDownBlack : AppFonts.dropDownGrey,
                      ),
                    ),
                  )
                  .toList(),
              value: partner,
              onChanged: widget.enabled
                  ? (val) {
                      widget.onChanged(val);
                      setState(() {
                        partner = val;
                      });
                    }
                  : null,
            ),
          ),
        ],
      );
}
