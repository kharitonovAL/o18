import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_staff/theme/theme.dart';

extension FormattedDate on DateTime {
  /// Date in format dd.MM.yyyy, without time
  String get shortDate {
    final formatter = DateFormat('dd.MM.yy');
    return formatter.format(this);
  }

  /// Date in format dd.MM.yyyy, with time
  String get shortDateWithTime {
    final formatter = DateFormat('dd.MM.yy HH:mm');
    return formatter.format(this);
  }
}



extension PhoneNumber on String {
  String get clearNumber =>
      replaceAll(' ', '').replaceAll('+7', '').replaceAll('(', '').replaceAll(')', '').replaceAll('-', '');

  String get toPhoneNumber {
    final list = characters.toList();
    list.insert(0, '+7');
    list.insert(1, ' (');
    list.insert(5, ') ');
    list.insert(9, '-');
    list.insert(12, '-');

    return list.join();
  }

  int get toInt => int.parse(this);
}

extension StatusIcon on UserRequest {
  Widget? get requestStatusIcon {
    if (status == RS.received) {
      return Container(
        alignment: Alignment.center,
        height: 32.h,
        width: 32.w,
        decoration: BoxDecoration(
          color: AppColors.grey_1,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(
          Icons.inbox_outlined,
          color: AppColors.grey_2,
          size: 20.w,
        ),
      );
    }

    if (status == RS.passedToTheChiefEngineer || status == RS.passedToTheMaster || status == RS.inProgress) {
      return Container(
        alignment: Alignment.center,
        height: 32.h,
        width: 32.w,
        decoration: BoxDecoration(
          color: AppColors.yellow_0,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(
          Icons.assignment_outlined,
          color: AppColors.yellow_1,
          size: 20.w,
        ),
      );
    }

    if (status == RS.closed) {
      if (requestType == RequestType.failure) {
        return Container(
          alignment: Alignment.center,
          height: 32.h,
          width: 32.w,
          decoration: BoxDecoration(
            color: AppColors.pink,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            Icons.check_circle_outline_outlined,
            color: AppColors.green_0,
            size: 20.w,
          ),
        );
      }

      if (requestType == RequestType.paid) {
        return Container(
          alignment: Alignment.center,
          height: 32.h,
          width: 32.w,
          decoration: BoxDecoration(
            color: AppColors.pink,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            Icons.check_circle_outline_outlined,
            color: AppColors.green_0,
            size: 20.w,
          ),
        );
      }

      return Container(
        alignment: Alignment.center,
        height: 32.h,
        width: 32.w,
        decoration: BoxDecoration(
          color: AppColors.transparent,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(
          Icons.check_circle_outline_outlined,
          color: AppColors.green_0,
          size: 20.w,
        ),
      );
    }

    if (status == RS.canceled) {
      if (requestType == RequestType.failure) {
        return Container(
          alignment: Alignment.center,
          height: 32.h,
          width: 32.w,
          decoration: BoxDecoration(
            color: AppColors.pink,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            Icons.cancel_outlined,
            color: AppColors.blueIcon,
            size: 20.w,
          ),
        );
      }

      if (requestType == RequestType.paid) {
        return Container(
          alignment: Alignment.center,
          height: 32.h,
          width: 32.w,
          decoration: BoxDecoration(
            color: AppColors.green_1,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            Icons.cancel_outlined,
            color: AppColors.blueIcon,
            size: 20.w,
          ),
        );
      }

      return Container(
        alignment: Alignment.center,
        height: 32.h,
        width: 32.w,
        decoration: BoxDecoration(
          color: AppColors.transparent,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(
          Icons.cancel_outlined,
          color: AppColors.blueIcon,
          size: 20.w,
        ),
      );
    }

    return null;
  }
}
