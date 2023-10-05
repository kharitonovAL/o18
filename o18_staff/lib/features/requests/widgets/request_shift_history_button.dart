import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_staff/theme/theme.dart';
import 'package:o18_staff/utils/utils.dart';

class RequestShiftHistoryButton extends StatelessWidget {
  final UserRequest? userRequest;

  const RequestShiftHistoryButton({
    required this.userRequest,
  });

  @override
  Widget build(
    BuildContext context,
  ) =>
      SizedBox(
        width: 374.h,
        height: 44.h,
        child: ElevatedButton(
          onPressed: () async => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                RequestDetailString.requestHistory,
                style: AppFonts.heading_4,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26.r),
              ),
              actionsPadding: EdgeInsets.only(
                bottom: 24.h,
                right: 24.w,
              ),
              content: SizedBox(
                width: 300.w,
                height: 300.h,
                child: userRequest!.requestHistory == null || userRequest!.requestHistory!.isEmpty
                    ? const Center(
                        child: Text(
                          RequestDetailString.noRequestShift,
                        ),
                      )
                    : Scrollbar(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: userRequest!.requestHistory!.length,
                          itemBuilder: (context, index) => ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            tileColor: index % 2 == 1 ? AppColors.white : AppColors.grey_3,
                            leading: Text('№ ${index + 1}'),
                            title: Text(
                              '${userRequest!.requestHistory![index]}',
                            ),
                          ),
                        ),
                      ),
              ),
              actions: [
                TextButton(
                  onPressed: Navigator.of(context).pop,
                  child: const Text(RequestDetailString.ok),
                ),
              ],
            ),
          ),
          style: ElevatedButton.styleFrom(
            shadowColor: Colors.transparent,
            backgroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.history,
                size: 22.w,
                color: AppColors.green_0,
              ),
              SizedBox(width: 13.w),
              Text(
                RequestDetailString.requestHistory,
                style: AppFonts.requestEditorButton,
              ),
            ],
          ),
        ),
      );
}
