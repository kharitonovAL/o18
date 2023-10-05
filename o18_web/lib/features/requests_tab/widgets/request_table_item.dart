import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_web/theme/theme.dart';
import 'package:o18_web/utils/extensions.dart';

class RequestTableItem extends StatefulWidget {
  final UserRequest request;
  final int itemIndex;
  final VoidCallback onTap;

  const RequestTableItem({
    required this.request,
    required this.itemIndex,
    required this.onTap,
  });

  @override
  State<RequestTableItem> createState() => _RequestTableItemState();
}

class _RequestTableItemState extends State<RequestTableItem> {
  @override
  Widget build(
    BuildContext context,
  ) =>
      MouseRegion(
        onEnter: (_) {
          // TODO
        },
        onExit: (_) {
          // TODO
        },
        child: GestureDetector(
          onTap: widget.onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24.w,
              vertical: 1.h,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: _rowColor(
                  widget.itemIndex,
                  widget.request,
                ),
                borderRadius: BorderRadius.circular(10.r),
              ),
              height: 52.h,
              child: Row(
                children: [
                  SizedBox(width: 17.w),
                  SizedBox(
                    width: 80.w,
                    child: Text(
                      '${widget.request.requestNumber}',
                      style: _textStyle(),
                    ),
                  ),
                  SizedBox(width: 30.w),
                  SizedBox(
                    width: 32.w,
                    height: 32.h,
                    child: widget.request.requestStatusIcon,
                  ),
                  SizedBox(width: 88.w),
                  SizedBox(
                    width: 185.w,
                    child: Text(
                      '${widget.request.address}',
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                      style: _textStyle(),
                    ),
                  ),
                  SizedBox(width: 40.w),
                  SizedBox(
                    width: 160.w,
                    child: Text(
                      '${widget.request.jobType}',
                      style: _textStyle(),
                    ),
                  ),
                  SizedBox(width: 48.w),
                  SizedBox(
                    width: 340.w,
                    child: Text(
                      '${widget.request.userRequest}',
                      style: _textStyle(),
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  SizedBox(width: 40.w),
                  SizedBox(
                    width: 75.w,
                    child: Text(
                      widget.request.requestDate!.shortDate,
                      style: _textStyle(),
                    ),
                  ),
                  SizedBox(width: 75.w),
                  SizedBox(
                    width: 75.w,
                    child: Text(
                      widget.request.responseDate!.shortDate,
                      style: _textStyle(),
                    ),
                  ),
                  SizedBox(width: 55.w),
                  SizedBox(
                    width: 240.w,
                    child: Text(
                      '${widget.request.userName}',
                      style: _textStyle(),
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  SizedBox(width: 20.w),
                  SizedBox(
                    width: 120.w,
                    child: Text(
                      '${widget.request.author}',
                      style: _textStyle(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Color _rowColor(
    int index,
    UserRequest request,
  ) {
    var color = AppColors.white;
    color = index % 2 == 1 ? AppColors.white : AppColors.grey_3;

    if (request.requestType == RequestType.failure) {
      if (request.status == RS.closed || request.status == RS.canceled) {
        color = index % 2 == 1 ? AppColors.white : AppColors.grey_3;
      } else {
        color = AppColors.pink;
      }
    }

    if (request.requestType == RequestType.paid) {
      if (request.status == RS.closed || request.status == RS.canceled) {
        color = index % 2 == 1 ? AppColors.white : AppColors.grey_3;
      } else {
        color = AppColors.green_1;
      }
    }

    return color;
  }

  TextStyle _textStyle() => TextStyle(
        fontSize: 17.sp,
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
