import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_staff/theme/style/app_colors.dart';
import 'package:o18_staff/theme/style/app_fonts.dart';
import 'package:o18_staff/utils/utils.dart';

class RequestListItem extends StatefulWidget {
  final UserRequest request;
  final VoidCallback onTap;

  const RequestListItem({
    required this.request,
    required this.onTap,
  });

  @override
  State<RequestListItem> createState() => _RequestListItemState();
}

class _RequestListItemState extends State<RequestListItem> {
  final phoneTextController = MaskedTextController(
    mask: '+7 (000) 000-00-00',
  );

  late String phoneNumber;

  @override
  void initState() {
    if (widget.request.phoneNumber != null) {
      phoneTextController.text = widget.request.phoneNumber!;
      phoneNumber = phoneTextController.text;
    }
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) =>
      GestureDetector(
        onTap: widget.onTap,
        child: Container(
          width: 374.w,
          height: 172.h,
          decoration: BoxDecoration(
            color: _itemColor(widget.request),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  // row that contains user's request, status icon, and number
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '№ ${widget.request.requestNumber}',
                      style: AppFonts.commonText,
                    ),
                    SizedBox(
                      width: 245.w,
                      child: Text(
                        widget.request.userRequest ?? 'no request',
                        overflow: TextOverflow.ellipsis,
                        style: _textStyle(),
                        maxLines: 2,
                      ),
                    ),
                    widget.request.requestStatusIcon ?? const SizedBox(),
                  ],
                ), // row that contains user's request and status icon
                SizedBox(height: 14.h),
                Row(
                  // row that contains response date and address
                  children: [
                    SizedBox(
                      width: 137.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            RequestTabString.requestToDoDate.toUpperCase(),
                            style: AppFonts.headerRow,
                          ),
                          Text(
                            widget.request.responseDate!.shortDate,
                            style: _textStyle(),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          RequestTabString.requestAddress.toUpperCase(),
                          style: AppFonts.headerRow,
                        ),
                        SizedBox(
                          width: 197.w,
                          child: Text(
                            widget.request.address ?? '',
                            style: _textStyle(),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    )
                  ],
                ), // row that contains response date and address
                SizedBox(height: 14.h),
                Row(
                  // row that holds user name and phone number
                  children: [
                    SizedBox(
                      width: 137.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            RequestTabString.userName.toUpperCase(),
                            style: AppFonts.headerRow,
                          ),
                          Text(
                            widget.request.userName ?? '',
                            style: _textStyle(),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          RequestTabString.phone.toUpperCase(),
                          style: AppFonts.headerRow,
                        ),
                        Text(
                          phoneNumber,
                          style: _textStyle(),
                        ),
                      ],
                    ),
                  ],
                ), // row that holds user nae and phone number
              ],
            ),
          ),
        ),
      );

  Color _itemColor(
    UserRequest request,
  ) {
    var color = AppColors.white;

    if (request.requestType == RequestType.failure) {
      if (request.status == RS.closed || request.status == RS.canceled) {
        color = AppColors.white;
      } else {
        color = AppColors.pink;
      }
    }

    if (request.requestType == RequestType.paid) {
      if (request.status == RS.closed || request.status == RS.canceled) {
        color = AppColors.white;
      } else {
        color = AppColors.green_1;
      }
    }

    return color;
  }

  TextStyle _textStyle() => TextStyle(
        fontSize: 15.sp,
        color: _setFontColor(),
        fontWeight: _setFontWeight(),
      );

  Color _setFontColor() {
    if (widget.request.responseDate != null) {
      if (widget.request.status == RS.received &&
          DateTime.now().isAfter(widget.request.responseDate!)) {
        return AppColors.red;
      }
      if (widget.request.status == RS.inProgress &&
          DateTime.now().isAfter(widget.request.responseDate!)) {
        return AppColors.red;
      }
      if (widget.request.status == RS.passedToTheChiefEngineer &&
          DateTime.now().isAfter(widget.request.responseDate!)) {
        return AppColors.red;
      }
      if (widget.request.status == RS.canceled) {
        return AppColors.grey_2;
      }
      if (widget.request.status == RS.closed) {
        return AppColors.grey_2;
      }
      if (widget.request.status == RS.passedToTheMaster &&
          DateTime.now().isAfter(widget.request.responseDate!)) {
        return AppColors.black;
      }
    }
    return Colors.black;
  }

  FontWeight _setFontWeight() =>
      widget.request.wasSeen != null && widget.request.wasSeen == false
          ? FontWeight.bold
          : FontWeight.normal;
}
