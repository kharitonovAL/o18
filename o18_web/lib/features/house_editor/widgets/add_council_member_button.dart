import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:o18_web/features/house_editor/cubit/cubit.dart';
import 'package:o18_web/features/widgets/alert_textfield.dart';
import 'package:o18_web/theme/theme.dart';
import 'package:o18_web/utils/utils.dart';

class AddCouncilMemberButton extends StatefulWidget {
  @override
  State<AddCouncilMemberButton> createState() => _AddCouncilMemberButtonState();
}

class _AddCouncilMemberButtonState extends State<AddCouncilMemberButton> {
  final _nameController = TextEditingController();

  final _phoneController = MaskedTextController(
    mask: '+7 (000) 000-00-00',
  );

  final _flatNumberController = TextEditingController();
  bool _isHouseKeeper = false;

  @override
  Widget build(
    BuildContext context,
  ) =>
      Center(
        child: SizedBox(
          width: 500.w,
          height: 50.h,
          child: OutlinedButton(
            onPressed: () async {
              final currentState = context.read<HouseCouncilCubit>().state;
              var houseKeeperExist = false;

              if (currentState is HouseCouncilLoaded) {
                houseKeeperExist = currentState.list.any(
                  (m) => m.isHousekeeper! == true,
                );
              }

              final validMember = await showDialog<bool>(
                context: context,
                builder: (context) => StatefulBuilder(
                  builder: (context, setState) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26.r),
                    ),
                    title: const Text(
                      HouseString.addCouncilMember,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: SizedBox(
                      width: 500.w,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AlertTextField(
                            controller: _nameController,
                            labelText: HouseString.memberName,
                          ),
                          SizedBox(height: 24.h),
                          AlertTextField(
                            controller: _flatNumberController,
                            labelText: HouseString.councilFlatNumber,
                          ),
                          SizedBox(height: 24.h),
                          AlertTextField(
                            controller: _phoneController,
                            labelText: HouseString.memberPhoneNumber,
                          ),
                          SizedBox(height: 24.h),
                          Visibility(
                            visible: !houseKeeperExist,
                            child: Row(
                              children: [
                                Checkbox(
                                  activeColor: AppColors.green_0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  value: _isHouseKeeper,
                                  onChanged: (val) => setState(() {
                                    _isHouseKeeper = val!;
                                  }),
                                ),
                                SizedBox(width: 10.w),
                                Text(
                                  HouseString.houseKeeper,
                                  style: AppFonts.houseMessageBody,
                                ),
                              ],
                            ),
                          ),
                        ],
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
                          if (_nameController.text.isNotEmpty &&
                              _flatNumberController.text.isNotEmpty &&
                              _phoneController.text.isNotEmpty) {
                            Navigator.of(context).pop(true);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  ErrorText.houseCouncilMemberRequiredFields,
                                ),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          HouseString.addMember,
                        ),
                      ),
                    ],
                    actionsPadding: EdgeInsets.only(
                      bottom: 40.h,
                      right: 40.w,
                    ),
                  ),
                ),
              );

              if (validMember ?? false) {
                await context.read<HouseCouncilCubit>().addCouncilMember(
                      name: _nameController.text,
                      phoneNumber: _phoneController.text.cleanNumber,
                      flatNumber: _flatNumberController.text,
                      isHouseKeeper: _isHouseKeeper,
                    );

                _nameController.clear();
                _flatNumberController.clear();
                _phoneController.clear();
                _isHouseKeeper = false;
              }
            },
            child: const Text(
              HouseString.houseAddCouncilMember,
              style: TextStyle(
                color: AppColors.grey_2,
              ),
            ),
          ),
        ),
      );
}
