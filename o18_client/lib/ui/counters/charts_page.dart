import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_client/ui/counters/widgets/is_show_difference_checkbox.dart';

class ChartsPage extends StatefulWidget {
  final Counter counter;
  const ChartsPage({
    required this.counter,
  });

  @override
  State<StatefulWidget> createState() => _ChartsPageState();
}

class _ChartsPageState extends State<ChartsPage> {
  DateFormat shortDateFormat = DateFormat('MM.yy');
  bool isShowDifference = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.counter.serviceTitle!),
        ),
        body: Column(
          children: [
            IsShowDifferenceCheckBox(
              isShowDifference: isShowDifference,
              onIsShowDifferenceStatusChanged: (value) => setState(() => isShowDifference = value),
            ),
            Expanded(
              child: Scrollbar(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: widget.counter.dayReadingList!.length * 56,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: maxY(),
                          barTouchData: BarTouchData(
                            enabled: false,
                            touchTooltipData: BarTouchTooltipData(
                              tooltipBgColor: Colors.transparent,
                              tooltipPadding: EdgeInsets.zero,
                              tooltipMargin: 8,
                              getTooltipItem: (
                                group,
                                groupIndex,
                                rod,
                                rodIndex,
                              ) =>
                                  BarTooltipItem(
                                rod.toY.round().toString(),
                                const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                interval: 36,
                                getTitlesWidget: (value, title) {
                                  final date = widget.counter.readingDateList![value.toInt() - 1] as DateTime;
                                  return SideTitleWidget(
                                    axisSide: title.axisSide,
                                    child: Text(
                                      shortDateFormat.format(date).toString(),
                                    ),
                                  );
                                },
                              ),
                            ),
                            leftTitles: const AxisTitles(),
                          ),
                          barGroups: barGroups(),
                          borderData: FlBorderData(show: false),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  double maxY() {
    if (widget.counter.dayReadingList != null) {
      if (widget.counter.dayReadingList!.isNotEmpty) {
        final dayReadingList = widget.counter.dayReadingList!.map((dynamic e) => double.parse('$e')).toList();
        final lastReading = dayReadingList.last;
        return lastReading;
      }
    }

    log(
      'dayReadingList is null',
      name: 'ChartsPage',
    );
    return 10000;
  }

  List<BarChartGroupData> barGroups() {
    if (widget.counter.dayReadingList != null && widget.counter.nightReadingList != null) {
      final dayReadingList = widget.counter.dayReadingList!.map((dynamic e) => double.parse('$e')).toList();
      final nightReadingList = widget.counter.nightReadingList!.map((dynamic e) => double.parse('$e')).toList();
      final barGroupsList = <BarChartGroupData>[];

      for (var i = 0; i < dayReadingList.length; i++) {
        final dayItem = dayReadingList[i];

        // define previous element in list
        final prevDayItem = i == 0 ? 0 : dayReadingList[i - 1];

        // define dayItemDifference value
        double? dayItemDifference;

        // if this is first element, then we have to subtract `0` from it
        if (i == 0) {
          dayItemDifference = dayItem - 0.0;
        } else {
          // otherwise we have to subtract `i` element from `i + 1` element
          dayItemDifference = dayItem - prevDayItem;
        }

        // if this couter has service title 'Электроснабжение', then `nightItem`,
        // `prevNightItem` and `nightItemDifference` will be initialized later
        double? nightItem;
        double? prevNightItem;
        double? nightItemDifference;

        if (widget.counter.serviceTitle == 'Электроснабжение') {
          nightItem = nightReadingList[i];
          prevNightItem = i == 0 ? 0 : nightReadingList[i - 1];

          // if this is first element, then we have to subtract `0` from it
          if (i == 0) {
            nightItemDifference = nightItem - 0.0;
          } else {
            // otherwise we have to subtract `i` element from `i + 1` element
            nightItemDifference = nightItem - prevNightItem;
          }
        }

        final data = BarChartGroupData(
          // here is `i + 1` because chart's bars cant be shown on zero X axis
          x: i + 1,
          barRods: [
            BarChartRodData(
              toY: isShowDifference ? dayItemDifference : dayItem,
              color: Colors.deepOrange,
            ),

            // if this couter has service title 'Электроснабжение', then we add second bar to charst to show
            if (widget.counter.serviceTitle == 'Электроснабжение')
              BarChartRodData(
                toY: isShowDifference ? nightItemDifference! : nightItem!,
                color: Colors.lightBlueAccent,
              ),
          ],

          // if this couter has service title 'Электроснабжение', then we will show two tooltip title: one for day
          // readings, and other for night reaings. otherwise it will have one tooltip with [0] index
          showingTooltipIndicators: widget.counter.serviceTitle == 'Электроснабжение' ? [0, 1] : [0],

          // if this couter has service title 'Электроснабжение', then we need to set them more separately to fit number
          // of readings
          barsSpace: widget.counter.serviceTitle == 'Электроснабжение' ? 12 : 2,
        );

        barGroupsList.add(data);
      }

      return barGroupsList;
    }

    return [];
  }
}
