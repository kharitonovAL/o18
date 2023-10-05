import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_client/theme/theme.dart';

class AccountText extends StatelessWidget {
  final Account account;
  final bool enabled;

  const AccountText({
    required this.account,
    this.enabled = true,
  });

  @override
  Widget build(
    BuildContext context,
  ) =>
      Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '№${account.accountNumber}, ${account.purpose},',
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 15.sp,
              color: enabled ? AppColors.black : AppColors.greyDisabled,
            ),
          ),
          SizedBox(width: 6.w),
          Text(
            '${account.debt} руб.',
            style: TextStyle(
              fontSize: 15.sp,
              color: '${account.debt}'.contains('-')
                  ? AppColors.red
                  : enabled
                      ? AppColors.black
                      : AppColors.greyDisabled,
              fontWeight: '${account.debt}'.contains('-') ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      );
}
