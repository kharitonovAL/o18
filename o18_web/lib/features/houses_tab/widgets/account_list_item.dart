import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_web/features/houses_tab/cubit/cubit.dart';
import 'package:o18_web/features/widgets/widgets.dart';
import 'package:o18_web/theme/style/app_colors.dart';
import 'package:o18_web/theme/style/app_fonts.dart';
import 'package:o18_web/utils/utils.dart';

class AccountListItem extends StatelessWidget {
  final Account account;
  final int? selectedIndex;
  final int itemIndex;
  final VoidCallback onTap;

  const AccountListItem({
    required this.account,
    required this.selectedIndex,
    required this.itemIndex,
    required this.onTap,
  });

  @override
  Widget build(
    BuildContext context,
  ) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          width: 587.w,
          height: 90.h,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: selectedIndex != null && itemIndex == selectedIndex
                ? [
                    const BoxShadow(
                      color: AppColors.shadow,
                      blurRadius: 12,
                    ),
                  ]
                : [],
          ),
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${HouseString.listItemAccountNumber} ${account.accountNumber}',
                      style: AppFonts.flatItemTitle,
                    ),
                    Row(
                      children: [
                        Text(
                          '${account.purpose}, ',
                          style: AppFonts.flatItemSubtitle,
                        ),
                        Text(
                          '${HouseString.listItemDebt} ${account.debt}',
                          style: account.debt.toString().contains('-')
                              ? TextStyle(
                                  fontSize: 17.sp,
                                  color: AppColors.red,
                                  fontWeight: FontWeight.bold,
                                )
                              : AppFonts.flatItemSubtitle,
                        ),
                      ],
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    final accountNumberController = TextEditingController();
                    final debtController = TextEditingController();

                    var selectedPurpose = account.purpose;
                    accountNumberController.text = account.accountNumber!;
                    debtController.text = account.debt.toString();

                    final changesConfirmed = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(
                          HouseString.makeEdits,
                          style: AppFonts.heading_4,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26.r),
                        ),
                        actionsPadding: EdgeInsets.only(
                          bottom: 40.h,
                          right: 40.w,
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppTextfield(
                              labelText: HouseString.enterNumber,
                              title: HouseString.enterAccount,
                              controller: accountNumberController,
                              width: 462,
                              digitsOnly: true,
                            ),
                            SizedBox(height: 24.h),
                            AppTextfield(
                              labelText: HouseString.enterSquare,
                              title: HouseString.flatSquare,
                              controller: debtController,
                              width: 462,
                              digitsOnly: true,
                            ),
                            SizedBox(height: 24.h),
                            AppDropdown(
                              title: HouseString.accountType,
                              list: AccountPurpose.list,
                              value: selectedPurpose,
                              onChanged: (val) => selectedPurpose = val,
                              width: 462,
                            ),
                          ],
                        ),
                        actions: [
                          OutlinedButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text(
                              HouseString.cancel,
                            ),
                          ),
                          AppElevatedButton(
                            title: HouseString.save,
                            onPressed: () => Navigator.of(context).pop(true),
                          ),
                        ],
                      ),
                    );

                    if (changesConfirmed ?? false) {
                      final accountUpdated =
                          await context.read<AccountListCubit>().saveChanges(
                                account: account,
                                number: accountNumberController.text,
                                debt: double.parse(debtController.text),
                                purpose: selectedPurpose,
                              );

                      if (accountUpdated) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              HouseString.updateSucceeded,
                            ),
                          ),
                        );
                        final flatId = context.read<AccountListCubit>().flatId;
                        await context.read<AccountListCubit>().loadAccountList(
                              flatId: flatId!,
                            );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              HouseString.updateFailed,
                            ),
                          ),
                        );
                      }
                    }
                  },
                  child: Container(
                    height: 44.h,
                    width: 44.w,
                    decoration: BoxDecoration(
                      color: AppColors.grey_3,
                      borderRadius: BorderRadius.circular(11.r),
                    ),
                    child: Icon(
                      Icons.mode_edit,
                      color: AppColors.green_0,
                      size: 26.w,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
