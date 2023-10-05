import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_web/features/houses_tab/cubit/cubit.dart';
import 'package:o18_web/features/widgets/widgets.dart';
import 'package:o18_web/theme/style/app_colors.dart';
import 'package:o18_web/theme/style/app_fonts.dart';
import 'package:o18_web/utils/utils.dart';

class FlatListItem extends StatelessWidget {
  final Flat flat;
  final int? selectedIndex;
  final int itemIndex;
  final VoidCallback onTap;

  const FlatListItem({
    required this.flat,
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
                      '${HouseString.flatItemTitle} ${flat.flatNumber}',
                      style: AppFonts.flatItemTitle,
                    ),
                    Text(
                      '${HouseString.flatItemSquare} ${flat.flatSquare} ${HouseString.flatItemResidents} ${flat.numberOfResidents}',
                      style: AppFonts.flatItemSubtitle,
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    final flatNumberController = TextEditingController();
                    final squareController = TextEditingController();
                    final residentsController = TextEditingController();

                    var selectedPurpose = flat.purpose;
                    flatNumberController.text = flat.flatNumber!;
                    squareController.text = flat.flatSquare.toString();
                    residentsController.text =
                        flat.numberOfResidents.toString();

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
                              title: HouseString.flatNumber,
                              controller: flatNumberController,
                              width: 462,
                            ),
                            SizedBox(height: 24.h),
                            AppTextfield(
                              labelText: HouseString.enterSquare,
                              title: HouseString.flatSquare,
                              controller: squareController,
                              width: 462,
                              digitsOnly: true,
                            ),
                            SizedBox(height: 24.h),
                            AppTextfield(
                              labelText: HouseString.enterResidentsAmount,
                              title: HouseString.residentsAmount,
                              controller: residentsController,
                              width: 462,
                              digitsOnly: true,
                            ),
                            SizedBox(height: 24.h),
                            AppDropdown(
                              title: HouseString.purpose,
                              list: FlatPurpose.list,
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
                      final flatUpdated =
                          await context.read<FlatListCubit>().saveChanges(
                                flat: flat,
                                flatNumber: flatNumberController.text,
                                square: double.parse(squareController.text),
                                numberOfResidents:
                                    int.parse(residentsController.text),
                                purpose: selectedPurpose,
                              );

                      if (flatUpdated) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              HouseString.updateSucceeded,
                            ),
                          ),
                        );
                        await context.read<FlatListCubit>().loadFlatList();
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
