import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:o18_web/features/login/widgets/widgets.dart';
import 'package:o18_web/theme/theme.dart';

class LoginDropdown extends StatefulWidget {
  final Function(String) onUserRoleChanged;

  const LoginDropdown({
    required this.onUserRoleChanged,
  });

  @override
  State<LoginDropdown> createState() => _LoginDropdownState();
}

class _LoginDropdownState extends State<LoginDropdown> {
  bool isShowMenu = false;
  String currentRole = UserRole.mcOperator;
  Color roleDropdownButtonColor = AppColors.grey_3;

  @override
  Widget build(
    BuildContext context,
  ) =>
      MouseRegion(
        onEnter: (_) =>
            setState(() => roleDropdownButtonColor = AppColors.grey_1),
        onExit: (_) =>
            setState(() => roleDropdownButtonColor = AppColors.grey_3),
        child: GestureDetector(
          onTap: () {
            setState(() {
              // ignore: avoid_bool_literals_in_conditional_expressions
              isShowMenu = isShowMenu ? false : true;
            });
          },
          child: Stack(
            children: [
              Container(
                height: 56.h,
                width: 418.w,
                decoration: BoxDecoration(
                  color: roleDropdownButtonColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 20.w,
                    right: 20.w,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        currentRole,
                        style: AppFonts.dropDownBlack,
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 20.w,
                        color: AppColors.green_0,
                      ),
                    ],
                  ),
                ),
              ),
              if (isShowMenu)
                Padding(
                  // 56 - is height of first container,
                  // 8 - is constraint between containers
                  padding: EdgeInsets.only(top: (56 + 8).h),
                  child: Container(
                    height: 166.h,
                    width: 418.w,
                    decoration: BoxDecoration(
                      boxShadow: [
                        // BoxShadow setup found here:
                        // https://devsheet.com/code-snippet/add-box-shadow-to-container-in-flutter/
                        BoxShadow(
                          color: AppColors.grey_6,
                          blurRadius: 90.r,
                          offset: Offset(0.w, 20.h),
                        )
                      ],
                      color: AppColors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.r),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var role in UserRole.list)
                            LoginDropdownItem(
                              onTap: () {
                                setState(() {
                                  isShowMenu = false;
                                  currentRole = role;
                                  widget.onUserRoleChanged(role);
                                });
                              },
                              userRole: role,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
}
