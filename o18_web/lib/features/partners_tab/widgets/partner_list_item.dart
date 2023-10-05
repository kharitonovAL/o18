import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_web/theme/theme.dart';

class PartnerListItem extends StatelessWidget {
  final Partner partner;
  final int itemIndex;
  final VoidCallback onTap;

  const PartnerListItem({
    required this.partner,
    required this.itemIndex,
    required this.onTap,
  });

  @override
  Widget build(
    BuildContext context,
  ) =>
      MouseRegion(
        onEnter: (_) {
          // TODO
        },
        onExit: (_) {
          // TODO
        },
        child: GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 1.h,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: _rowColor(
                  itemIndex,
                ),
                borderRadius: BorderRadius.circular(10.r),
              ),
              height: 52.h,
              child: Row(
                children: [
                  SizedBox(width: 17.w),
                  SizedBox(
                    width: 372.w,
                    child: Text(
                      partner.title!,
                      style: AppFonts.tableItemBlack,
                    ),
                  ),
                  SizedBox(width: 132.w),
                  SizedBox(
                    width: 202.w,
                    child: Text(
                      partner.fullAddress,
                      style: AppFonts.tableItemBlack,
                    ),
                  ),
                  SizedBox(width: 110.w),
                  SizedBox(
                    width: 365.w,
                    child: Text(
                      '${partner.managerName}, Тел.: ${partner.phoneNumber}',
                      style: AppFonts.tableItemBlack,
                    ),
                  ),
                  SizedBox(width: 108.w),
                  SizedBox(
                    width: 356.w,
                    child: Text(
                      '${partner.bankTitle}, БИК ${partner.bankBic}',
                      style: AppFonts.tableItemBlack,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Color _rowColor(
    int index,
  ) =>
      index % 2 == 1 ? AppColors.white : AppColors.grey_3;
}
