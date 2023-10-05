import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:o18_client/theme/theme.dart';

class AlertTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;

  const AlertTextField({
    required this.controller,
    required this.labelText,
  });

  @override
  Widget build(
    BuildContext context,
  ) =>
      SizedBox(
        height: 56.h,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 20.h,
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
          ),
        ),
      );
}
