import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:o18_web/theme/theme.dart';
import 'package:o18_web/utils/utils.dart';

class PartnerHeaderRow extends StatelessWidget {
  const PartnerHeaderRow();

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
              PartnerString.title.toUpperCase(),
              style: AppFonts.headerRow,
            ),
            SizedBox(width: 430.w),
            Text(
              PartnerString.address.toUpperCase(),
              style: AppFonts.headerRow,
            ),
            SizedBox(width: 263.w),
            Text(
              PartnerString.contacts.toUpperCase(),
              style: AppFonts.headerRow,
            ),
            SizedBox(width: 400.w),
            Text(
              PartnerString.requisites.toUpperCase(),
              style: AppFonts.headerRow,
            ),
          ],
        ),
      );
}
