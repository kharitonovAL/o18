import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:o18_web/features/counters_tab/cubit/counters_tab_cubit.dart';
import 'package:o18_web/theme/theme.dart';
import 'package:o18_web/utils/utils.dart';

class CurrentMonthCheckbox extends StatefulWidget {
  const CurrentMonthCheckbox();

  @override
  State<CurrentMonthCheckbox> createState() => _CurrentMonthCheckboxState();
}

class _CurrentMonthCheckboxState extends State<CurrentMonthCheckbox> {
  var _value = false;

  @override
  Widget build(
    BuildContext context,
  ) =>
      Row(
        children: [
          Checkbox(
            activeColor: AppColors.green_0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            value: _value,
            onChanged: (val) {
              setState(() {
                _value = val!;
              });
              context.read<CountersTabCubit>().currentMonth(
                    currentMonthOnly: val!,
                  );
            },
          ),
          SizedBox(width: 10.w),
          Text(
            CounterString.currentMonth,
            style: AppFonts.currentMonth,
          ),
        ],
      );
}
