import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_web/features/houses_tab/cubit/cubit.dart';
import 'package:o18_web/features/widgets/widgets.dart';
import 'package:o18_web/theme/theme.dart';
import 'package:o18_web/utils/utils.dart';

class OwnerListItem extends StatelessWidget {
  final Owner owner;
  final int? selectedIndex;
  final int itemIndex;

  const OwnerListItem({
    required this.owner,
    required this.selectedIndex,
    required this.itemIndex,
  });

  @override
  Widget build(
    BuildContext context,
  ) =>
      Container(
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
                    owner.name!,
                    style: AppFonts.flatItemTitle,
                  ),
                  Text(
                    '${HouseString.ownerSquare} ${owner.squareMeters}, ${HouseString.ownerPhone} ${owner.phoneNumber}',
                    style: AppFonts.flatItemSubtitle,
                  )
                ],
              ),
              GestureDetector(
                onTap: () async {
                  final nameController = TextEditingController();
                  final phoneController = MaskedTextController(
                    mask: '+7 (000) 000-00-00',
                  );
                  final emailController = TextEditingController();
                  final squareController = TextEditingController();

                  nameController.text = owner.name!;
                  phoneController.text = owner.phoneNumber.toString();
                  emailController.text = owner.email!;
                  squareController.text = owner.squareMeters.toString();

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
                            title: HouseString.name,
                            labelText: HouseString.enterName,
                            controller: nameController,
                            width: 462,
                          ),
                          SizedBox(height: 24.h),
                          AppTextfield(
                            title: HouseString.phoneNumber,
                            labelText: HouseString.enterPhoneNumber,
                            controller: phoneController,
                            width: 462,
                            digitsOnly: true,
                          ),
                          SizedBox(height: 24.h),
                          AppTextfield(
                            title: HouseString.email,
                            labelText: HouseString.enterEmail,
                            controller: emailController,
                            width: 462,
                          ),
                          SizedBox(height: 24.h),
                          AppTextfield(
                            title: HouseString.ownerSquareFull,
                            labelText: HouseString.enterSquare,
                            controller: squareController,
                            width: 462,
                            digitsOnly: true,
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
                    final ownerUpdated =
                        await context.read<OwnerListCubit>().saveChanges(
                              owner: owner,
                              name: nameController.text,
                              phoneNumber:
                                  int.parse(phoneController.text.cleanNumber),
                              email: emailController.text,
                              square: double.parse(squareController.text),
                            );

                    if (ownerUpdated) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            HouseString.updateSucceeded,
                          ),
                        ),
                      );
                      final accountNumber =
                          context.read<OwnerListCubit>().accNumber;
                      await context.read<OwnerListCubit>().loadOwnerList(
                            accountNumber: accountNumber!,
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
      );
}
