// ignore_for_file: must_be_immutable

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:o18_staff/theme/theme.dart';
import 'package:o18_staff/utils/utils.dart';

class AppDropdown extends StatefulWidget {
  final String title;
  final List<String> list;
  final Function(String?) onChanged;
  final double width;
  final bool enabled;
  String? value;
  String? Function(String?)? validator;

  AppDropdown({
    required this.title,
    required this.list,
    required this.onChanged,
    this.width = 314,
    this.value,
    this.enabled = true,
    this.validator,
  });

  @override
  State<AppDropdown> createState() => _AppDropdownState();
}

class _AppDropdownState extends State<AppDropdown> {
  @override
  Widget build(
    BuildContext context,
  ) =>
      Flexible(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: AppFonts.commonText,
            ),
            SizedBox(height: 8.h),
            DropdownButtonHideUnderline(
              child: DropdownButtonFormField2(
                validator: widget.validator,
                hint: Text(
                  AppString.selectFromList,
                  style: AppFonts.dropDownGrey,
                ),
                menuItemStyleData: MenuItemStyleData(
                  height: 35.h,
                  padding: EdgeInsets.only(left: 17.w),
                ),
                buttonStyleData: ButtonStyleData(
                  padding: EdgeInsets.only(left: 17.w),
                  width: widget.width.w,
                  height: 46.h,
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
                value: widget.value,
                onChanged: widget.enabled
                    ? (val) {
                        widget.onChanged(val!.toString());
                        setState(() {
                          widget.value = val.toString();
                        });
                      }
                    : null,
              ),
            ),
          ],
        ),
      );
}
