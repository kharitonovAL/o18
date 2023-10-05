import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_web/theme/style/app_colors.dart';

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

extension TopicTitle on String {
  String get toEnglish {
    final newString = toLowerCase();
    final finalString = newString
        .replaceAll('а', 'a')
        .replaceAll('б', 'b')
        .replaceAll('в', 'v')
        .replaceAll('г', 'g')
        .replaceAll('д', 'd')
        .replaceAll('е', 'e')
        .replaceAll('ё', 'yo')
        .replaceAll('ж', 'zh')
        .replaceAll('з', 'z')
        .replaceAll('и', 'i')
        .replaceAll('й', 'i')
        .replaceAll('к', 'k')
        .replaceAll('л', 'l')
        .replaceAll('м', 'm')
        .replaceAll('н', 'n')
        .replaceAll('о', 'o')
        .replaceAll('п', 'p')
        .replaceAll('р', 'r')
        .replaceAll('с', 's')
        .replaceAll('т', 't')
        .replaceAll('у', 'u')
        .replaceAll('ф', 'f')
        .replaceAll('х', 'h')
        .replaceAll('ц', 'c')
        .replaceAll('ч', 'ch')
        .replaceAll('ш', 'sh')
        .replaceAll('щ', 'sh')
        .replaceAll('ъ', '_')
        .replaceAll('ы', 'i')
        .replaceAll('ь', '_')
        .replaceAll('э', 'e')
        .replaceAll('ю', 'yu')
        .replaceAll('я', 'ya');

    return finalString;
  }

  String get toRussian {
    final newString = toLowerCase();
    final finalString = newString
        .replaceAll('a', 'а')
        .replaceAll('b', 'б')
        .replaceAll('v', 'в')
        .replaceAll('g', 'г')
        .replaceAll('d', 'д')
        .replaceAll('e', 'е')
        .replaceAll('yo', 'ё')
        .replaceAll('zh', 'ж')
        .replaceAll('z', 'з')
        .replaceAll('i', 'и')
        .replaceAll('i', 'й')
        .replaceAll('k', 'к')
        .replaceAll('l', 'л')
        .replaceAll('m', 'м')
        .replaceAll('n', 'н')
        .replaceAll('o', 'о')
        .replaceAll('p', 'п')
        .replaceAll('r', 'р')
        .replaceAll('s', 'с')
        .replaceAll('t', 'т')
        .replaceAll('u', 'у')
        .replaceAll('f', 'ф')
        .replaceAll('h', 'х')
        .replaceAll('c', 'ц')
        .replaceAll('ch', 'ч')
        .replaceAll('sh', 'ш')
        .replaceAll('sh', 'щ')
        .replaceAll('i', 'ы')
        .replaceAll('e', 'э')
        .replaceAll('yu', 'ю')
        .replaceAll('ya', 'я');

    return finalString;
  }
}

extension CleanNumber on String {
  String get cleanNumber => replaceAll(' ', '')
      .replaceAll('+7', '')
      .replaceAll('(', '')
      .replaceAll(')', '')
      .replaceAll('-', '');
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

    if (status == RS.passedToTheChiefEngineer ||
        status == RS.passedToTheMaster ||
        status == RS.inProgress) {
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
