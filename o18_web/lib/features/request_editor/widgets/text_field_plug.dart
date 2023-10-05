// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:o18_web/theme/theme.dart';
import 'package:o18_web/utils/utils.dart';

class TextFieldPlug extends StatelessWidget {
  final String title;
  final String? label;
  final double width;
  final double height;
  String? Function(String?)? validator;

  TextFieldPlug({
    required this.title,
    this.width = 430,
    this.height = 56,
    this.label,
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
          Text(
            title,
            style: AppFonts.commonText,
          ),
          SizedBox(height: 8.h),
          SizedBox(
            width: width.w,
            height: height.h,
            child: TextFormField(
              enabled: false,
              style: AppFonts.emailPassword,
              cursorColor: AppColors.green_0,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 20.h,
                ),
                fillColor: AppColors.grey_3,
                filled: true,
                labelText: label ?? RequestEditorString.loadingData,
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
