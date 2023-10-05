import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:o18_staff/app/store/app_store.dart';
import 'package:o18_staff/features/login/store/login_store.dart';
import 'package:o18_staff/theme/theme.dart';
import 'package:o18_staff/utils/utils.dart';
import 'package:provider/provider.dart';

class AppTabBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(70.h);

  @override
  Widget build(
    BuildContext context,
  ) =>
      Container(
        height: 70.h,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.appBarShadow,
              blurRadius: 40.r,
              offset: Offset(0, 0.75.h),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Text(
                TabViewString.title,
                style: AppFonts.heading_4,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text(TabViewString.attention),
                      content: const Text(TabViewString.logoutQuestion),
                      actions: [
                        TextButton(
                          onPressed: Navigator.of(context).pop,
                          child: const Text(TabViewString.cancel),
                        ),
                        TextButton(
                          onPressed: () {
                            Provider.of<LoginStore>(
                              context,
                              listen: false,
                            ).logout();

                            Provider.of<AppStore>(
                              context,
                              listen: false,
                            ).status = AuthenticationStatus.unauthenticated;

                            Navigator.of(context).pop();
                          },
                          child: const Text(TabViewString.yes),
                        ),
                      ],
                    ),
                  );
                },
                child: Container(
                  width: 38.w,
                  height: 38.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.r),
                    color: AppColors.grey_5,
                  ),
                  child: Icon(
                    Icons.person_outline,
                    size: 23.w,
                    color: AppColors.green_0,
                  ),
                ),
              ),
            )
          ],
        ),
      );
}
