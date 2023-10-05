import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_staff/features/login/store/login_store.dart';
import 'package:o18_staff/features/requests/store/request_detail_store.dart';
import 'package:o18_staff/features/requests/widgets/widgets.dart';
import 'package:o18_staff/theme/theme.dart';
import 'package:o18_staff/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class RequestDetailView extends StatefulWidget {
  final UserRequest userRequest;

  const RequestDetailView({
    required this.userRequest,
  });

  @override
  State<RequestDetailView> createState() => _RequestDetailViewState();
}

class _RequestDetailViewState extends State<RequestDetailView> {
  late final RequestDetailStore store;
  Staff? loggedInStaff;
  bool loggedInStaffIsMaster = false;

  @override
  void initState() {
    store = context.read<RequestDetailStore>();
    store.loadOwner(
      ownerId: widget.userRequest.ownerId!,
    );
    store.loadImageList(
      userRequestId: widget.userRequest.objectId!,
    );

    loggedInStaff = context.read<LoginStore>().currentStaff;

    if (loggedInStaff != null) {
      if (loggedInStaff!.role == StaffRole.master) {
        loggedInStaffIsMaster = true;

        if (widget.userRequest.staffId != null && widget.userRequest.staffId != '') {
          store.loadStaff(
            staffId: widget.userRequest.staffId!,
          );
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) =>
      SafeArea(
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 70.h,
            shadowColor: AppColors.appBarShadow,
            title: Text(
              '${RequestDetailString.requestNumber} ${widget.userRequest.requestNumber}',
              style: AppFonts.heading_3,
            ),
            leading: const BackButton(
              color: AppColors.green_0,
            ),
          ),
          body: Observer(
            builder: (_) {
              switch (store.owner?.status) {
                case FutureStatus.pending:
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(),
                        SizedBox(height: 8.h),
                        const Text(RequestDetailString.loadingData),
                      ],
                    ),
                  );

                case FutureStatus.rejected:
                  return const Center(
                    child: Text(RequestDetailString.requestError),
                  );

                case FutureStatus.fulfilled:
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 16.h,
                        left: 20.w,
                        right: 20.w,
                      ),
                      child: Container(
                        width: 374.w,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 32.w,
                            vertical: 28.h,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${RequestDetailString.requestFromDate} ${widget.userRequest.requestDate?.shortDate}',
                                style: AppFonts.commonTextBold,
                              ),
                              Text(
                                '${RequestDetailString.requestEndDate} ${widget.userRequest.responseDate?.shortDate}',
                                style: AppFonts.commonTextGrey,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 23.h),
                                child: Text(
                                  RequestDetailString.content.toUpperCase(),
                                  style: AppFonts.commonTextGrey,
                                ),
                              ),
                              Text(
                                '${widget.userRequest.userRequest}',
                                style: AppFonts.commonTextBold,
                              ),
                              Visibility(
                                visible:
                                    widget.userRequest.requestNote != null && widget.userRequest.requestNote! != '',
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 15.h),
                                      child: Text(
                                        RequestDetailString.requestNote.toUpperCase(),
                                        style: AppFonts.commonTextGrey,
                                      ),
                                    ),
                                    Text(
                                      '${widget.userRequest.requestNote}',
                                      style: AppFonts.commonTextBold,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 15.h),
                                child: Text(
                                  RequestDetailString.owner.toUpperCase(),
                                  style: AppFonts.commonTextGrey,
                                ),
                              ),
                              Text(
                                '${store.owner?.value?.name}',
                                style: AppFonts.commonTextBold,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 15.h),
                                child: Text(
                                  RequestDetailString.phoneNumber.toUpperCase(),
                                  style: AppFonts.commonTextGrey,
                                ),
                              ),
                              GestureDetector(
                                onTap: _callUserPhone,
                                child: Text(
                                  '${store.owner?.value?.phoneNumber.toString().toPhoneNumber}',
                                  style: AppFonts.commonTextGreen,
                                ),
                              ),
                              if (store.staff?.status == FutureStatus.pending) const LinearProgressIndicator(),
                              if (store.staff?.status == FutureStatus.fulfilled)
                                if (loggedInStaffIsMaster)
                                  Padding(
                                    padding: EdgeInsets.only(top: 15.h),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          RequestDetailString.staff.toUpperCase(),
                                          style: AppFonts.commonTextGrey,
                                        ),
                                        Text(
                                          store.staff?.value?.name ?? RequestDetailString.staffNotSet,
                                          style: AppFonts.commonTextBold,
                                        ),
                                        Visibility(
                                          visible:
                                              widget.userRequest.staffId != null && widget.userRequest.staffId != '',
                                          child: GestureDetector(
                                            onTap: () => store.staff?.value?.phoneNumber != null
                                                ? _callStaffPhone(
                                                    phoneNumber: store.staff?.value?.phoneNumber?.toInt ?? 0,
                                                  )
                                                : null,
                                            child: Text(
                                              '${store.staff?.value?.phoneNumber?.toPhoneNumber}',
                                              style: AppFonts.commonTextGreen,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 32.h),
                                child: Divider(
                                  thickness: 2.h,
                                  color: AppColors.grey_3,
                                ),
                              ),
                              RequestPhotoButton(
                                imageList: store.imageList?.value ?? [],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 12.h),
                                child: SizedBox(
                                  width: 374.h,
                                  height: 44.h,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AddPhotoView(
                                            userRequest: widget.userRequest,
                                            store: store,
                                          ),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shadowColor: Colors.transparent,
                                      backgroundColor: AppColors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12.r),
                                      ),
                                    ),
                                    child: Text(
                                      RequestDetailString.addPhoto,
                                      style: AppFonts.requestEditorButton,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 12.h),
                                child: ShiftRequestButton(
                                  store: store,
                                  userRequest: widget.userRequest,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 12.h),
                                child: CloseRequestButton(
                                  userRequest: widget.userRequest,
                                  store: store,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );

                // ignore: no_default_cases
                default:
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(),
                        SizedBox(height: 8.h),
                        const Text(RequestDetailString.loadingData),
                      ],
                    ),
                  );
              }
            },
          ),
        ),
      );

  void _callUserPhone() async {
    try {
      final phone = '+7${widget.userRequest.phoneNumber}';
      await launchUrl(Uri(
        scheme: 'tel',
        path: phone,
      ));
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 3),
          content: Text(
            ErrorText.callFuctionError,
          ),
        ),
      );
      log(
        e.toString(),
        name: 'RequestDetailView: _callUserPhone()',
      );
    }
  }

  void _callStaffPhone({
    required int phoneNumber,
  }) async {
    try {
      final phone = '+7$phoneNumber';
      await launchUrl(Uri(
        scheme: 'tel',
        path: phone,
      ));
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 3),
          content: Text(
            ErrorText.callFuctionError,
          ),
        ),
      );
      log(
        e.toString(),
        name: 'RequestDetailView: _callStaffPhone()',
      );
    }
  }
}
