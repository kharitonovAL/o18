import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:o18_staff/theme/theme.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    required this.title,
    required this.onPressed,
  });

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(
    BuildContext context,
  ) =>
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.green_0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        key: const Key('loginForm_continue_raisedButton'),
        onPressed: onPressed,
        child: Text(
          title,
          style: AppFonts.buttonText,
        ),
      );
}
