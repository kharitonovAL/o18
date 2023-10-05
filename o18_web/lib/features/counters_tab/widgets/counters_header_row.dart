import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:o18_web/theme/theme.dart';
import 'package:o18_web/utils/utils.dart';

class CountersHeaderRow extends StatelessWidget {
  const CountersHeaderRow();

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
              CounterString.service.toUpperCase(),
              style: AppFonts.headerRow,
            ),
            SizedBox(width: 145.w),
            SizedBox(
              width: 90.w,
              child: Text(
                CounterString.serialNumber.toUpperCase(),
                style: AppFonts.headerRow,
              ),
            ),
            SizedBox(width: 125.w),
            SizedBox(
              width: 153.w,
              child: Text(
                CounterString.lastReadingsDate.toUpperCase(),
                style: AppFonts.headerRow,
              ),
            ),
            SizedBox(width: 27.w),
            SizedBox(
              width: 140.w,
              child: Text(
                CounterString.lastReadingsDay.toUpperCase(),
                style: AppFonts.headerRow,
              ),
            ),
            SizedBox(width: 32.w),
            SizedBox(
              width: 140.w,
              child: Text(
                CounterString.lastReadingsNight.toUpperCase(),
                style: AppFonts.headerRow,
              ),
            ),
            SizedBox(width: 40.w),
            SizedBox(
              width: 118.w,
              child: Text(
                CounterString.currentReadingsDate.toUpperCase(),
                style: AppFonts.headerRow,
              ),
            ),
            SizedBox(width: 55.w),
            SizedBox(
              width: 137.w,
              child: Text(
                CounterString.currentReadingsDay.toUpperCase(),
                style: AppFonts.headerRow,
              ),
            ),
            SizedBox(width: 48.w),
            SizedBox(
              width: 140.w,
              child: Text(
                CounterString.currentReadingsNight.toUpperCase(),
                style: AppFonts.headerRow,
              ),
            ),
            SizedBox(width: 35.w),
            Text(
              CounterString.address.toUpperCase(),
              style: AppFonts.headerRow,
            ),
          ],
        ),
      );
}
