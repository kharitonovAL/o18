import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_web/features/house_editor/cubit/cubit.dart';
import 'package:o18_web/features/house_editor/view/view.dart';
import 'package:o18_web/features/houses_tab/cubit/cubit.dart';
import 'package:o18_web/theme/theme.dart';
import 'package:o18_web/utils/utils.dart';

class HouseListItem extends StatelessWidget {
  final House house;
  final int itemIndex;
  final VoidCallback onTap;

  const HouseListItem({
    required this.house,
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
                    width: 300.w,
                    child: Text(
                      house.addressToString,
                      style: AppFonts.houseTableitemBlack,
                    ),
                  ),
                  SizedBox(width: 310.w),
                  SizedBox(
                    width: 35.w,
                    child: Text(
                      house.floorsCount.toString(),
                      style: AppFonts.houseTableitemBlack,
                    ),
                  ),
                  SizedBox(width: 110.w),
                  SizedBox(
                    width: 35.w,
                    child: Text(
                      house.flatsCount.toString(),
                      style: AppFonts.houseTableitemBlack,
                    ),
                  ),
                  SizedBox(width: 500.w),
                  TextButton(
                    onPressed: () async {
                      final _messageController = TextEditingController();

                      final sendConfirmed = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26.r),
                          ),
                          title: const Text(HouseString.sendNotification),
                          content: SizedBox(
                            width: 500.w,
                            child: TextField(
                              controller: _messageController,
                              decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.w,
                                  vertical: 20.h,
                                ),
                                fillColor: AppColors.grey_3,
                                filled: true,
                                labelText: HouseString.enterMessage,
                                labelStyle: AppFonts.dropDownGrey,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12.r),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text(
                                HouseString.cancel,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                if (_messageController.text.isNotEmpty) {
                                  Navigator.of(context).pop(true);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        ErrorText.enterHouseMessage,
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: const Text(
                                HouseString.sendMessage,
                              ),
                            ),
                          ],
                        ),
                      );

                      if (sendConfirmed ?? false) {
                        final messageWasSent = await context
                            .read<HousesTabCubit>()
                            .sendNotification(
                              message: _messageController.text,
                              houseId: house.objectId!,
                            );

                        messageWasSent
                            ? ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    HouseString.messageWasSent,
                                  ),
                                ),
                              )
                            : ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    HouseString.messageWasNotSent,
                                  ),
                                ),
                              );
                      }
                    },
                    child: Text(
                      HouseString.sendNotification,
                      style: AppFonts.houseTableButtonGreen,
                    ),
                  ),
                  SizedBox(width: 52.w),
                  TextButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MultiBlocProvider(
                          providers: [
                            BlocProvider(
                              create: (context) => HouseCardCubit(
                                house: house,
                              ),
                            ),
                            BlocProvider(
                              create: (context) => HouseCouncilCubit(
                                house: house,
                              ),
                            ),
                            BlocProvider(
                              create: (context) => HouseMessagesCubit(
                                house: house,
                              ),
                            ),
                          ],
                          child: HouseCardView(
                            house: house,
                          ),
                        ),
                      ),
                    ),
                    child: Text(
                      HouseString.card,
                      style: AppFonts.houseTableButtonGreen,
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
