import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_staff/theme/style/app_colors.dart';
import 'package:o18_staff/theme/style/app_fonts.dart';

class MessageListItem extends StatelessWidget {
  final StaffMessage message;
  final VoidCallback onTap;

  const MessageListItem({
    required this.message,
    required this.onTap,
  });

  @override
  Widget build(
    BuildContext context,
  ) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          height: 82.h,
          width: 374.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: AppColors.white,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Row(
              children: [
                Container(
                  width: 44.w,
                  height: 44.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11.r),
                    color: AppColors.grey_3,
                  ),
                  child: Center(
                    child: Icon(
                      message.wasSeen! ? Icons.mail_outline : Icons.mail,
                      color: AppColors.green_0,
                      size: 26.w,
                    ),
                  ),
                ),
                SizedBox(width: 20.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      message.title ?? 'no title',
                      style: message.wasSeen! ? AppFonts.messageNumberNormal : AppFonts.messageNumberBold,
                    ),
                    Text(
                      message.body ?? 'no body',
                      style: AppFonts.messageText,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
