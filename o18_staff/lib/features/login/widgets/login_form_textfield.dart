import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:o18_staff/theme/theme.dart';

class LoginFormTextfield extends StatefulWidget {
  final Function(String) onChanged;
  final String labelText;
  final bool isValidInput;
  final bool isPasswordField;

  const LoginFormTextfield({
    required this.onChanged,
    required this.labelText,
    required this.isValidInput,
    this.isPasswordField = false,
  });

  @override
  State<LoginFormTextfield> createState() => _LoginFormTextfieldState();
}

class _LoginFormTextfieldState extends State<LoginFormTextfield> {
  /// Store current value is text obscured or not, also uses
  /// to show/hide password when click on eye icon
  late bool obscureText;

  @override
  void initState() {
    if (widget.isPasswordField) {
      obscureText = true;
    } else {
      obscureText = false;
    }
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) =>
      SizedBox(
        width: 314.w,
        height: 46.h,
        child: TextField(
          style: AppFonts.emailPassword,
          cursorColor: AppColors.green_0,
          onChanged: widget.onChanged,
          obscureText: obscureText,
          keyboardType: widget.isPasswordField ? TextInputType.text : TextInputType.emailAddress,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            suffixIcon: widget.isPasswordField
                ? GestureDetector(
                    onTap: () => setState(() {
                      // ignore: avoid_bool_literals_in_conditional_expressions
                      obscureText = obscureText ? false : true;
                    }),
                    child: Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: obscureText
                          ? Icon(
                              Icons.remove_red_eye_outlined,
                              size: 28.w,
                              color: AppColors.grey_2,
                            )
                          : Icon(
                              Icons.remove_red_eye,
                              size: 28.w,
                              color: AppColors.green_0,
                            ),
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 20.h,
            ),
            fillColor: AppColors.grey_3,
            filled: true,
            labelText: widget.labelText,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(12.r),
              ),
            ),
            focusedBorder: widget.isValidInput
                ? OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.r),
                    ),
                  )
                : OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.red),
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.r),
                    ),
                  ),
          ),
        ),
      );
}
