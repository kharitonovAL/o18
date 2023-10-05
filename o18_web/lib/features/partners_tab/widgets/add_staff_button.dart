// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_web/features/partners_tab/cubit/cubit.dart';
import 'package:o18_web/features/widgets/widgets.dart';
import 'package:o18_web/theme/theme.dart';
import 'package:o18_web/utils/utils.dart';

class AddStaffButton extends StatelessWidget {
  final _nameController = TextEditingController();
  final _phoneController = MaskedTextController(
    mask: '+7 (000) 000-00-00',
  );
  final _positionController = TextEditingController();
  final _emailController = TextEditingController();
  String? _selectedRole;

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
              final validStaff = await showDialog<bool>(
                context: context,
                builder: (context) => StatefulBuilder(
                  builder: (context, setState) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26.r),
                    ),
                    title: const Text(
                      PartnerString.addStaff,
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
                            labelText: PartnerString.staffName,
                          ),
                          SizedBox(height: 24.h),
                          AlertTextField(
                            controller: _positionController,
                            labelText: PartnerString.staffPosition,
                          ),
                          SizedBox(height: 24.h),
                          AlertTextField(
                            controller: _phoneController,
                            labelText: PartnerString.phone,
                          ),
                          SizedBox(height: 24.h),
                          AlertTextField(
                            controller: _emailController,
                            labelText: PartnerString.email,
                          ),
                          SizedBox(height: 24.h),
                          AppDropdown(
                            list: StaffRole.list,
                            onChanged: (role) {
                              _selectedRole = role;
                              print(_selectedRole);
                            },
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text(
                          PartnerString.cancel,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          if (_nameController.text.isNotEmpty &&
                              _positionController.text.isNotEmpty &&
                              _phoneController.text.isNotEmpty &&
                              _emailController.text.isNotEmpty &&
                              _selectedRole != null) {
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
                          PartnerString.addStaff,
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

              if (validStaff ?? false) {
                await context.read<StaffCubit>().addStaff(
                      name: _nameController.text,
                      phoneNumber: _phoneController.text.cleanNumber,
                      position: _positionController.text,
                      email: _emailController.text,
                      role: _selectedRole!,
                    );

                _nameController.clear();
                _positionController.clear();
                _phoneController.clear();
                _emailController.clear();
              }
            },
            child: const Text(
              PartnerString.addStaff,
              style: TextStyle(
                color: AppColors.grey_2,
              ),
            ),
          ),
        ),
      );
}
