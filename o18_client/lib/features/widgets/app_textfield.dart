import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:o18_client/theme/theme.dart';

class AppTextfield extends StatelessWidget {
  final String? title;
  final String labelText;
  final Function(String)? onChanged;
  final double width;
  final double height;
  final int maxLines;
  final TextEditingController controller;
  final bool enabled;
  final bool digitsOnly;
  String? Function(String?)? validator;

  AppTextfield({
    required this.labelText,
    required this.controller,
    this.title,
    this.onChanged,
    this.width = 314,
    this.height = 46,
    this.maxLines = 1,
    this.enabled = true,
    this.digitsOnly = false,
    this.validator,
  });

  @override
  Widget build(
    BuildContext context,
  ) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title != null
              ? Text(
                  title!,
                  style: AppFonts.commonText,
                )
              : const SizedBox(),
          SizedBox(height: 8.h),
          SizedBox(
            width: width.w,
            height: height.h,
            child: TextFormField(
              inputFormatters: digitsOnly
                  ? [
                      FilteringTextInputFormatter.allow(
                        // ignore: unnecessary_raw_strings
                        RegExp(r'[0-9.-]'),
                      ),
                    ]
                  : [],
              enabled: enabled,
              maxLines: maxLines,
              controller: controller,
              style: enabled ? AppFonts.textFieldBlack : AppFonts.textFieldGrey,
              onChanged: onChanged,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                enabled: enabled,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 17.w,
                  vertical: 14.h,
                ),
                fillColor: AppColors.grey_3,
                filled: true,
                labelText: labelText,
                labelStyle: AppFonts.dropDownGrey,
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
              validator: validator,
            ),
          ),
        ],
      );
}
