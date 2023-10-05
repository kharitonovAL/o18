import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_web/theme/theme.dart';

class CounterListItem extends StatefulWidget {
  final Counter counter;
  final int itemIndex;

  const CounterListItem({
    required this.counter,
    required this.itemIndex,
  });

  @override
  State<CounterListItem> createState() => _CounterListItemState();
}

class _CounterListItemState extends State<CounterListItem> {
  DateFormat dateFormat = DateFormat('dd.MM.yyyy');

  @override
  Widget build(
    BuildContext context,
  ) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 1.h,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: _rowColor(widget.itemIndex),
            borderRadius: BorderRadius.circular(10.r),
          ),
          height: 52.h,
          child: Row(
            children: [
              SizedBox(width: 17.w),
              SizedBox(
                width: 165.w,
                child: Text(
                  widget.counter.serviceTitle!,
                  style: AppFonts.counterListItemBlack,
                ),
              ),
              SizedBox(width: 35.w),
              SizedBox(
                width: 150.w,
                child: Text(
                  widget.counter.serialNumber!,
                  style: AppFonts.counterListItemBlack,
                ),
              ),
              SizedBox(width: 63.w),
              SizedBox(
                width: 115.w,
                child: Text(
                  dateFormat
                      .format(widget.counter.readingDateList!.last as DateTime),
                  style: AppFonts.counterListItemBlack,
                ),
              ),
              SizedBox(width: 63.w),
              SizedBox(
                width: 115.w,
                child: Text(
                  '${widget.counter.dayReadingList!.last}',
                  style: AppFonts.counterListItemBlack,
                ),
              ),
              SizedBox(width: 63.w),
              SizedBox(
                width: 115.w,
                child: Text(
                  '${widget.counter.nightReadingList!.last}',
                  style: AppFonts.counterListItemBlack,
                ),
              ),
              SizedBox(width: 63.w),
              SizedBox(
                width: 115.w,
                child: Text(
                  dateFormat.format(widget.counter.currentReadingDate!),
                  style: AppFonts.counterListItemBlack,
                ),
              ),
              SizedBox(width: 63.w),
              SizedBox(
                width: 115.w,
                child: Text(
                  '${widget.counter.currentDayReading}',
                  style: AppFonts.counterListItemBlack,
                ),
              ),
              SizedBox(width: 63.w),
              SizedBox(
                width: 115.w,
                child: Text(
                  '${widget.counter.currentNightReading}',
                  style: AppFonts.counterListItemBlack,
                ),
              ),
              SizedBox(width: 63.w),
              SizedBox(
                width: 250.w,
                child: Text(
                  '${widget.counter.address}',
                  style: AppFonts.counterListItemBlack,
                ),
              ),
            ],
          ),
        ),
      );

  Color _rowColor(
    int index,
  ) =>
      index % 2 == 1 ? AppColors.white : AppColors.grey_3;
}
