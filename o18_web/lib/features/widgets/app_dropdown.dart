// ignore_for_file: must_be_immutable

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:o18_web/theme/theme.dart';
import 'package:o18_web/utils/utils.dart';

class AppDropdown extends StatefulWidget {
  final List<String> list;
  final String? value;
  final Function(String?) onChanged;
  final String? title;
  final double width;
  final bool enabled;
  String? Function(String?)? validator;

  AppDropdown({
    required this.list,
    required this.onChanged,
    this.title,
    this.width = 430,
    this.value,
    this.enabled = true,
    this.validator,
  });

  @override
  State<AppDropdown> createState() => _AppDropdownState();
}

class _AppDropdownState extends State<AppDropdown> {
  String? value;

  @override
  void initState() {
    if (widget.value != null) {
      value = widget.value;
    }
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) =>
      Flexible(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: widget.title != null,
              child: Column(
                children: [
                  Text(
                    widget.title ?? '',
                    style: AppFonts.commonText,
                  ),
                  SizedBox(height: 8.h),
                ],
              ),
            ),
            DropdownButtonHideUnderline(
              child: DropdownButtonFormField2(
                validator: widget.validator,
                hint: Text(
                  AppString.selectFromList,
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
                  padding: EdgeInsets.only(left: 28.w),
                ),
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
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
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Row(
                          children: [
                            Text(
                              e,
                              style: widget.enabled ? AppFonts.dropDownBlack : AppFonts.dropDownGrey,
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
                value: value,
                onChanged: widget.enabled
                    ? (val) {
                        widget.onChanged(val!.toString());
                        setState(() {
                          value = val.toString();
                        });
                      }
                    : null,
              ),
            ),
          ],
        ),
      );
}
