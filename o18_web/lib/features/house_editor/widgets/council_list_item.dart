import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_web/features/house_editor/cubit/cubit.dart';
import 'package:o18_web/features/widgets/widgets.dart';
import 'package:o18_web/theme/theme.dart';
import 'package:o18_web/utils/utils.dart';

class CouncilListItem extends StatefulWidget {
  final CouncilMember member;
  final List<CouncilMember> memberList;
  final House house;
  final int currentIndex;

  const CouncilListItem({
    required this.memberList,
    required this.member,
    required this.house,
    required this.currentIndex,
  });

  @override
  State<CouncilListItem> createState() => _CouncilListItemState();
}

class _CouncilListItemState extends State<CouncilListItem> {
  final _nameController = TextEditingController();
  final _phoneController = MaskedTextController(
    mask: '+7 (000) 000-00-00',
  );
  final _flatNumberController = TextEditingController();
  bool _isHouseKeeper = false;

  @override
  void initState() {
    _nameController.text = widget.member.name!;
    _phoneController.text = widget.member.phoneNumber!;
    _flatNumberController.text = widget.member.flatNumber!;
    _isHouseKeeper = widget.member.isHousekeeper!;

    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) =>
      GestureDetector(
        onTap: () async {
          bool? deleteConfirmed = false;
          final validMember = await showDialog<bool>(
            context: context,
            builder: (context) => StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26.r),
                ),
                title: const Text(
                  HouseString.makeEdits,
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
                        /// show Checkbox widget if current council member
                        /// is houseKeeper or if there is now houseKeeper
                        /// in the list
                        visible: !widget.memberList
                                .any((m) => m.isHousekeeper! == true) ||
                            widget.member.isHousekeeper!,
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
                      HouseString.saveMemberChanges,
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
                            title: const Text(HouseString.attention),
                            content:
                                const Text(HouseString.memberDeleteConfirm),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: const Text(
                                  HouseString.cancel,
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
                                  HouseString.yes,
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
                      HouseString.delete,
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
            await context.read<HouseCouncilCubit>().deleteMember(
                  member: widget.member,
                );
          }

          if (validMember ?? false) {
            await context.read<HouseCouncilCubit>().updateMember(
                  member: widget.member,
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
                    color:
                        _isHouseKeeper ? AppColors.green_0 : AppColors.grey_3,
                    borderRadius: BorderRadius.circular(11.r),
                  ),
                  child: Icon(
                    Icons.person_outline,
                    color:
                        _isHouseKeeper ? AppColors.grey_3 : AppColors.green_0,
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
                        '${_flatNumberController.text}, ${_phoneController.text}',
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
