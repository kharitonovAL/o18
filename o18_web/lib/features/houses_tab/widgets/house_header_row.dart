import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:o18_web/theme/theme.dart';
import 'package:o18_web/utils/utils.dart';

class HouseHeaderRow extends StatelessWidget {
  const HouseHeaderRow();

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
              HouseString.address.toUpperCase(),
              style: AppFonts.headerRow,
            ),
            SizedBox(width: 558.w),
            Text(
              HouseString.floorAmount.toUpperCase(),
              style: AppFonts.headerRow,
            ),
            SizedBox(width: 55.w),
            Text(
              HouseString.flatAmount.toUpperCase(),
              style: AppFonts.headerRow,
            ),
          ],
        ),
      );
}
