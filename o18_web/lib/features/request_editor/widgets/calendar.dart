import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_web/theme/style/app_colors.dart';
import 'package:o18_web/theme/style/app_fonts.dart';
import 'package:o18_web/utils/utils.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  final List<UserRequest> userRequestList;
  final Function(DateTime) onDateSelected;
  final Function(DateTime) onCalendarCreated;
  final DateTime? responseDate;
  final bool enabled;

  const Calendar({
    required this.userRequestList,
    required this.onDateSelected,
    required this.onCalendarCreated,
    this.responseDate,
    this.enabled = true,
  });

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> with TickerProviderStateMixin {
  late final ValueNotifier<List<UserRequest>> _selectedEvents;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final now = DateTime.now();

  @override
  void initState() {
    _selectedDay = widget.responseDate ?? _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));

    /// when the calendar created in parent widget,
    /// set reponse date to tomorrow
    final now = DateTime.now();
    final tomorrow = now.add(const Duration(days: 1));
    widget.onCalendarCreated(tomorrow);

    super.initState();
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<UserRequest> _getEventsForDay(DateTime day) {
    final list = widget.userRequestList.toList();

    list.retainWhere((e) {
      final respDate = DateTime(
        e.responseDate!.year,
        e.responseDate!.month,
        e.responseDate!.day,
      );

      final selectedDate = DateTime(
        day.year,
        day.month,
        day.day,
      );
      return respDate == selectedDate;
    });

    return list;
  }

  void _onDaySelected(
    DateTime selectedDay,
    DateTime focusedDay,
  ) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      widget.onDateSelected(selectedDay);

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 126.h),
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(26.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 20.h,
                horizontal: 40.w,
              ),
              child: TableCalendar<UserRequest>(
                // don't apply screen_utils for this value,
                // or the calendar rows will be thinner
                rowHeight: 40,
                locale: 'ru_RU',
                firstDay: widget.userRequestList.first.requestDate!,
                lastDay: DateTime(now.year + 1, now.month, now.day),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                eventLoader: _getEventsForDay,
                startingDayOfWeek: StartingDayOfWeek.monday,
                headerStyle: HeaderStyle(
                  titleTextStyle: AppFonts.commonText,
                  titleCentered: true,
                  formatButtonVisible: false,
                  leftChevronIcon: const Icon(
                    Icons.chevron_left,
                    color: AppColors.green_0,
                  ),
                  rightChevronIcon: const Icon(
                    Icons.chevron_right,
                    color: AppColors.green_0,
                  ),
                  leftChevronVisible: widget.enabled,
                  rightChevronVisible: widget.enabled,
                ),
                calendarStyle: CalendarStyle(
                  weekendTextStyle: const TextStyle(color: AppColors.red),
                  todayDecoration: BoxDecoration(
                    color: widget.enabled
                        ? AppColors.green_0.withOpacity(0.5)
                        : AppColors.greyDisabled,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: widget.enabled
                        ? AppColors.green_0
                        : AppColors.greyDisabled,
                    shape: BoxShape.circle,
                  ),
                  outsideDaysVisible: false,
                ),
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekendStyle: TextStyle(
                    color: AppColors.red,
                  ),
                ),
                onDaySelected: widget.enabled ? _onDaySelected : null,
                onPageChanged: widget.enabled
                    ? (focusedDay) {
                        _focusedDay = focusedDay;
                      }
                    : null,
                onHeaderTapped: widget.enabled
                    ? (_) {
                        setState(() {
                          _selectedDay = DateTime.now();
                          _focusedDay = DateTime.now();
                        });
                      }
                    : null,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Expanded(
            child: ValueListenableBuilder<List<UserRequest>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) => ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(
                      color: widget.enabled
                          ? AppColors.green_0
                          : AppColors.greyDisabled,
                    ),
                    borderRadius: BorderRadius.circular(26.r),
                  ),
                  child: ListTile(
                    title: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Text(
                        '${RequestEditorString.requestNumber} '
                        '${value[index].requestNumber}: '
                        '${value[index].userRequest}',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
}
