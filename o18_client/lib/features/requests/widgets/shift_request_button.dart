import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_client/features/requests/store/request_detail_store.dart';
import 'package:o18_client/features/tab_page/view/tab_view.dart';
import 'package:o18_client/features/widgets/widgets.dart';
import 'package:o18_client/utils/utils.dart';

class ShiftRequestButton extends StatelessWidget {
  final UserRequest userRequest;
  final RequestDetailStore store;

  ShiftRequestButton({
    required this.userRequest,
    required this.store,
  });

  final _reasonController = TextEditingController();
  bool validResponse = false;

  @override
  Widget build(
    BuildContext context,
  ) =>
      SizedBox(
        width: 374.h,
        height: 44.h,
        child: OutlinedButton(
          onPressed: () async => showDialog(
            context: context,
            builder: (context) => StatefulBuilder(
              builder: (cintext, setState) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                title: const Text(RequestDetailString.attention),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(RequestDetailString.dateShiftInfo),
                    Padding(
                      padding: EdgeInsets.only(top: 16.h),
                      child: AppTextfield(
                        labelText: RequestDetailString.shiftReason,
                        validator: (_) => validResponse ? null : RequestDetailString.fillField,
                        controller: _reasonController,
                      ),
                    ),
                  ],
                ),
                actionsPadding: EdgeInsets.only(
                  right: 20.w,
                  bottom: 20.h,
                ),
                actions: [
                  TextButton(
                    onPressed: Navigator.of(context).pop,
                    child: const Text(RequestDetailString.cancel),
                  ),
                  TextButton(
                    child: const Text(RequestDetailString.continueAction),
                    onPressed: () async {
                      setState(() {
                        validResponse = _reasonController.text.isEmpty;
                      });

                      if (!validResponse) {
                        final today = DateTime.now();
                        final nextYear = DateTime(
                          today.year + 1,
                          today.month,
                          today.day,
                        );

                        final selectedDate = await showDatePicker(
                          context: context,
                          initialDate: today,
                          firstDate: today,
                          lastDate: nextYear,
                        );

                        if (selectedDate != null) {
                          final responseDate = DateTime(
                            selectedDate.year,
                            selectedDate.month,
                            selectedDate.day,
                            12,
                          );

                          userRequest.setAdd(
                            UserRequest.keyRequestHistory,
                            '${RequestDetailString.shiftReason}: ${_reasonController.text}, '
                            '${RequestDetailString.newResponseDate}: ${responseDate.shortDate}',
                          );
                          userRequest.responseDate = responseDate;

                          final response = await userRequest.update();
                          final requestUpdated = response.success;

                          if (requestUpdated) {
                            if (userRequest.userToken != null) {
                              await store.sendPushToToken(
                                title: '${RequestDetailString.requestNotification} ${userRequest.requestNumber}',
                                message: '${RequestDetailString.dateShiftedFrom} '
                                    '${userRequest.responseDate?.shortDate}'
                                    '${RequestDetailString.dateShiftedTo} ${responseDate.shortDate}',
                                token: userRequest.userToken!,
                              );
                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration: Duration(seconds: 3),
                                content: Text(
                                  RequestDetailString.dateWasShifted,
                                ),
                              ),
                            );

                            Navigator.of(context)
                              ..pop()
                              ..pop();

                            unawaited(
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => TabView(),
                                  ),
                                  (route) => false),
                            );
                          }
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          child: const Text(RequestDetailString.shiftDate),
        ),
      );
}
