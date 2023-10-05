import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:o18_web/app/bloc/app_bloc.dart';
import 'package:o18_web/theme/theme.dart';
import 'package:o18_web/utils/utils.dart';

class AppTabBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController controller;

  const AppTabBar({
    required this.controller,
  });

  @override
  Size get preferredSize => Size.fromHeight(90.h);

  @override
  Widget build(
    BuildContext context,
  ) =>
      Container(
        color: AppColors.white,
        height: 90.h,
        width: MediaQuery.of(context).size.width.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 34.w,
                    right: 76.w,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      TabViewString.title,
                      style: AppFonts.heading_2,
                    ),
                  ),
                ),
                SizedBox(
                  width: 530.w,
                  height: 90.h,
                  child: TabBar(
                    isScrollable: true,
                    indicatorColor: AppColors.green_0,
                    indicatorWeight: 3.h,
                    indicatorSize: TabBarIndicatorSize.label,
                    controller: controller,
                    labelColor: AppColors.green_0,
                    labelStyle: AppFonts.menuSelected,
                    unselectedLabelColor: AppColors.black,
                    unselectedLabelStyle: AppFonts.menuUnselected,
                    tabs: const [
                      Tab(text: TabViewString.requests),
                      Tab(text: TabViewString.houses),
                      Tab(text: TabViewString.counters),
                      Tab(text: TabViewString.partners),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: 40.w),
              child: OutlinedButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26.r),
                    ),
                    title: const Text(TabViewString.logout),
                    content: const Text(TabViewString.logoutQuestion),
                    actions: [
                      TextButton(
                        onPressed: Navigator.of(context).pop,
                        child: const Text(TabViewString.cancel),
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<AppBloc>().add(AppLogoutRequested());
                          Navigator.of(context).pop();
                        },
                        child: const Text(TabViewString.yes),
                      ),
                    ],
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(TabViewString.logout),
                    SizedBox(width: 10.w),
                    Icon(
                      Icons.logout,
                      size: 22.w,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
}
