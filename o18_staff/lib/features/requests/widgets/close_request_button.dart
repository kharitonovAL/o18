import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_staff/features/requests/store/request_detail_store.dart';
import 'package:o18_staff/features/tab_page/view/view.dart';
import 'package:o18_staff/features/widgets/widgets.dart';
import 'package:o18_staff/utils/utils.dart';

class CloseRequestButton extends StatelessWidget {
  final UserRequest userRequest;
  final RequestDetailStore store;

  CloseRequestButton({
    required this.userRequest,
    required this.store,
  });

  final _responseController = TextEditingController();

  @override
  Widget build(
    BuildContext context,
  ) =>
      SizedBox(
        width: 374.h,
        height: 44.h,
        child: OutlinedButton(
          child: const Text(RequestDetailString.closeRequest),
          onPressed: () async => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              title: const Text(RequestDetailString.attention),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(RequestDetailString.closeRequestMessage),
                  Padding(
                    padding: EdgeInsets.only(top: 16.h),
                    child: AppTextfield(
                      controller: _responseController,
                      labelText: RequestDetailString.closeRequestComment,
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
                    userRequest.status = RS.closed;
                    userRequest.response = _responseController.text.isEmpty
                        ? RequestDetailString.requestIsClosed
                        : _responseController.text;
                    userRequest.responseDate = DateTime.now();
                    final response = await userRequest.update();
                    final isUserRequestUpdated = response.success;

                    if (isUserRequestUpdated) {
                      if (userRequest.userToken != null) {
                        await store.sendPushToToken(
                          title: '${RequestDetailString.requestNotification} ${userRequest.requestNumber}',
                          message: RequestDetailString.requestIsClosed,
                          token: userRequest.userToken!,
                        );
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(seconds: 3),
                          content: Text(
                            RequestDetailString.requestIsClosed,
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
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
