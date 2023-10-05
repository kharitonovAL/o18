import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_web/theme/style/app_colors.dart';
import 'package:o18_web/theme/style/app_fonts.dart';
import 'package:o18_web/utils/utils.dart';

class HouseMessageListItem extends StatelessWidget {
  final HouseMessage message;

  HouseMessageListItem({
    required this.message,
  });

  final dateWithTime = DateFormat('dd.MM.yy HH:mm');

  @override
  Widget build(
    BuildContext context,
  ) =>
      GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26.r),
              ),
              title: Text(
                '${message.title} ${HouseString.from} ${dateWithTime.format(message.date!)}',
                style: AppFonts.houseMessageTitle,
              ),
              content: SizedBox(
                width: 300.w,
                child: Text(
                  message.body!,
                  style: AppFonts.houseMessageTitle,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: Navigator.of(context).pop,
                  child: const Text(HouseString.ok),
                ),
              ],
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: SizedBox(
            height: 80.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 44.h,
                  width: 44.w,
                  decoration: BoxDecoration(
                    color: AppColors.grey_3,
                    borderRadius: BorderRadius.circular(11.r),
                  ),
                  child: Icon(
                    Icons.messenger_outline,
                    color: AppColors.green_0,
                    size: 26.w,
                  ),
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${message.title} ${HouseString.from} ${dateWithTime.format(message.date!)}',
                        style: AppFonts.houseMessageTitle,
                      ),
                      Text(
                        message.body!,
                        style: AppFonts.houseMessageBody,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Divider(
                        thickness: 2.h,
                        color: AppColors.grey_3,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
