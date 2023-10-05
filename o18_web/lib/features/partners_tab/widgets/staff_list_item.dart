import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_web/features/partners_tab/cubit/cubit.dart';
import 'package:o18_web/features/partners_tab/widgets/widgets.dart';
import 'package:o18_web/features/widgets/widgets.dart';
import 'package:o18_web/theme/theme.dart';
import 'package:o18_web/utils/utils.dart';

class StaffListItem extends StatefulWidget {
  final Partner? partner;
  final Staff staff;

  const StaffListItem({
    required this.partner,
    required this.staff,
  });

  @override
  State<StaffListItem> createState() => _StaffListItemState();
}

class _StaffListItemState extends State<StaffListItem> {
  final _nameController = TextEditingController();
  final _phoneController = MaskedTextController(
    mask: '+7 (000) 000-00-00',
  );
  final _positionController = TextEditingController();
  final _emailController = TextEditingController();
  String? _role;
  var _isRegistered = false;

  @override
  void initState() {
    _nameController.text = widget.staff.name!;
    _phoneController.text = widget.staff.phoneNumber.toString();
    _positionController.text = widget.staff.position!;
    _emailController.text = widget.staff.email!;
    _isRegistered = widget.staff.isRegistered ?? false;
    _role = widget.staff.role;
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) =>
      GestureDetector(
        onTap: () async {
          bool? deleteConfirmed = false;
          bool? registrationConfirmed = false;
          bool? deleteRegistrationConfirmed = false;

          final validMember = await showDialog<bool>(
            context: context,
            builder: (context) => StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26.r),
                ),
                title: const Text(
                  PartnerString.makeEdits,
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
                        value: _role,
                        onChanged: (role) => _role == role,
                      ),
                      SizedBox(height: 24.h),
                      Visibility(
                        visible: !widget.staff.isRegistered!,
                        child: RegisterStaffButton(
                          staff: widget.staff,
                          registrationConfirmed: (confirmed) => setState(() => registrationConfirmed = confirmed),
                        ),
                      ),
                      Visibility(
                        visible: widget.staff.isRegistered!,
                        child: DeleteStaffRegistrationButton(
                          staff: widget.staff,
                          deleteConfirmed: (confirmed) => setState(() => deleteRegistrationConfirmed = confirmed),
                        ),
                      )
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
                          _role != null) {
                        Navigator.of(context).pop(true);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              ErrorText.staffRequiredFields,
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      PartnerString.save,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      deleteConfirmed = await showDialog<bool>(
                        context: context,
                        builder: (context) => StatefulBuilder(
                          builder: (context, setState) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(26.r),
                            ),
                            title: const Text(PartnerString.attention),
                            content: const Text(
                              PartnerString.staffDeleteConfirm,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(false),
                                child: const Text(
                                  PartnerString.cancel,
                                ),
                              ),
                              TextButton(
                                /// first `pop(true)` passes `bool` to `deleteConfirmed`
                                /// and closes confirmation alert. and second
                                /// `pop` close member's editor alert
                                onPressed: () => Navigator.of(context)
                                  ..pop(true)
                                  ..pop(),
                                child: const Text(
                                  PartnerString.yes,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.red,
                    ),
                    child: const Text(
                      PartnerString.deletePartner,
                      style: TextStyle(
                        color: AppColors.red,
                      ),
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

          if (deleteConfirmed ?? false) {
            await context.read<StaffCubit>().deleteStaff(
                  staff: widget.staff,
                );
          }

          if (registrationConfirmed ?? false) {
            await context.read<StaffCubit>().registerStaff(
                  staff: widget.staff,
                );
          }

          if (deleteRegistrationConfirmed ?? false) {
            await context.read<StaffCubit>().deleteStaffRegistration(
                  staff: widget.staff,
                );
          }

          if (validMember ?? false) {
            await context.read<StaffCubit>().updateStaff(
                  staff: widget.staff,
                  name: _nameController.text,
                  phoneNumber: _phoneController.text.cleanNumber,
                  email: _emailController.text,
                  position: _positionController.text,
                  role: _role!,
                  isRegistered: _isRegistered,
                );

            _nameController.clear();
            _phoneController.clear();
            _emailController.clear();
            _positionController.clear();
            _isRegistered = false;
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: SizedBox(
            height: 80.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 44.h,
                  width: 44.w,
                  decoration: BoxDecoration(
                    color: _isRegistered ? AppColors.green_0 : AppColors.grey_3,
                    borderRadius: BorderRadius.circular(11.r),
                  ),
                  child: Icon(
                    Icons.person_outline,
                    color: _isRegistered ? AppColors.grey_3 : AppColors.green_0,
                    size: 26.w,
                  ),
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _nameController.text,
                        style: AppFonts.houseMessageTitle,
                      ),
                      Text(
                        '${_positionController.text}, ${_phoneController.text}',
                        style: AppFonts.houseMessageBody,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Divider(
                        thickness: 2.h,
                        color: AppColors.grey_3,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
