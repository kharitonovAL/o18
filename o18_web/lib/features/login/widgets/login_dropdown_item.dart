import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:o18_web/theme/theme.dart';

class LoginDropdownItem extends StatefulWidget {
  final VoidCallback onTap;
  final String userRole;

  const LoginDropdownItem({
    required this.onTap,
    required this.userRole,
  });

  @override
  _LoginDropdownItemState createState() => _LoginDropdownItemState();
}

class _LoginDropdownItemState extends State<LoginDropdownItem> {
  Color itemColor = AppColors.white;

  @override
  Widget build(
    BuildContext context,
  ) =>
      MouseRegion(
        onEnter: (_) => setState(() => itemColor = AppColors.grey_1),
        onExit: (_) => setState(() => itemColor = AppColors.white),
        child: GestureDetector(
          onTap: widget.onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 14.w,
            ),
            child: Container(
              width: 390.w,
              height: 31.h,
              decoration: BoxDecoration(
                color: itemColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(6.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  14.w,
                  5.h,
                  14.w,
                  5.h,
                ),
                child: Text(
                  widget.userRole,
                  style: AppFonts.dropDownBlack,
                ),
              ),
            ),
          ),
        ),
      );
}
