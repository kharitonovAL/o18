import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:o18_web/theme/theme.dart';

class AppDropdown extends StatelessWidget {
  final Function(dynamic) onValueChanged;

  const AppDropdown({
    required this.onValueChanged,
  });

  @override
  Widget build(
    BuildContext context,
  ) =>
      DropdownButtonFormField(
        items: UserRole.list
            .map(
              (item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: AppFonts.dropDownBlack,
                ),
              ),
            )
            .toList(),
        value: UserRole.mcOperator,
        onChanged: (value) {
          final callback = onValueChanged;
          if (value != null) {
            callback(value);
          }
        },
        elevation: 4,
        style: AppFonts.dropDownBlack,
        icon: Icon(
          Icons.keyboard_arrow_down,
          size: 20.w,
          color: AppColors.green_0,
        ),
        isExpanded: true,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 28.h,
            vertical: 24.w,
          ),
          filled: true,
          fillColor: AppColors.grey_3,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(12.r),
            ),
          ),
          errorStyle: TextStyle(
            color: AppColors.red,
            letterSpacing: 0.75.w,
            height: 1.h,
          ),
        ),
        dropdownColor: AppColors.white,
      );
}
