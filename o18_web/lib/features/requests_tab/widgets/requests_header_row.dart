import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:o18_web/theme/theme.dart';
import 'package:o18_web/utils/utils.dart';

class RequestsHeaderRow extends StatelessWidget {
  const RequestsHeaderRow();

  @override
  Widget build(
    BuildContext context,
  ) =>
      Padding(
        padding: EdgeInsets.only(
          left: 40.w,
          top: 32.h,
          right: 40.w,
          bottom: 24.w,
        ),
        child: Row(
          children: [
            Text(
              RequestTabString.requestNumber.toUpperCase(),
              style: AppFonts.headerRow,
            ),
            SizedBox(width: 40.w),
            Text(
              RequestTabString.requestStatus.toUpperCase(),
              style: AppFonts.headerRow,
            ),
            SizedBox(width: 62.w),
            Text(
              RequestTabString.requestAddress.toUpperCase(),
              style: AppFonts.headerRow,
            ),
            SizedBox(width: 180.w),
            Text(
              RequestTabString.requestCategory.toUpperCase(),
              style: AppFonts.headerRow,
            ),
            SizedBox(width: 130.w),
            Text(
              RequestTabString.requestDetails.toUpperCase(),
              style: AppFonts.headerRow,
            ),
            SizedBox(width: 245.w),
            Text(
              RequestTabString.requestCreateDate.toUpperCase(),
              style: AppFonts.headerRow,
            ),
            SizedBox(width: 30.w),
            Text(
              RequestTabString.requestToDoDate.toUpperCase(),
              style: AppFonts.headerRow,
            ),
            SizedBox(width: 40.w),
            Text(
              RequestTabString.requestOwner.toUpperCase(),
              style: AppFonts.headerRow,
            ),
            SizedBox(width: 180.w),
            Text(
              RequestTabString.requestAuthor.toUpperCase(),
              style: AppFonts.headerRow,
            ),
          ],
        ),
      );
}
