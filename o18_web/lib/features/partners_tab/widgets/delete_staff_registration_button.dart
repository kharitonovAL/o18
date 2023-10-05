import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_web/theme/theme.dart';
import 'package:o18_web/utils/utils.dart';

class DeleteStaffRegistrationButton extends StatelessWidget {
  final Staff staff;
  final Function(bool?) deleteConfirmed;

  const DeleteStaffRegistrationButton({
    required this.staff,
    required this.deleteConfirmed,
  });

  @override
  Widget build(
    BuildContext context,
  ) =>
      SizedBox(
        height: 56.h,
        width: 500.w,
        child: OutlinedButton(
          onPressed: () async {
            final confirmed = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26.r),
                ),
                title: const Text(
                  PartnerString.deleteRegistration,
                ),
                content: const Text(
                  PartnerString.deleteRegistrationMessage,
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text(
                      PartnerString.cancel,
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.red,
                    ),
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text(
                      PartnerString.deleteRegistration,
                      style: TextStyle(
                        color: AppColors.red,
                      ),
                    ),
                  ),
                ],
              ),
            );

            if (confirmed ?? false) {
              deleteConfirmed(confirmed);
              Navigator.of(context).pop();
            }
          },
          child: const Text(
            PartnerString.deleteRegistration,
          ),
        ),
      );
}
