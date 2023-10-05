import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:o18_web/theme/theme.dart';

class NewRequestButton extends StatelessWidget {
  const NewRequestButton({
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(
    BuildContext context,
  ) =>
      SizedBox(
        width: 40.w,
        height: 40.h,
        child: IconButton(
          padding: EdgeInsets.zero,
          onPressed: onPressed,
          icon: Icon(
            Icons.add_circle_rounded,
            color: AppColors.green_0,
            size: 40.h,
          ),
        ),
      );
}
