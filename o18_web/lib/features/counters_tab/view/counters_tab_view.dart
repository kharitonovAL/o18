import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:o18_web/features/counters_tab/cubit/counters_tab_cubit.dart';
import 'package:o18_web/features/counters_tab/widgets/widgets.dart';
import 'package:o18_web/features/widgets/widgets.dart';
import 'package:o18_web/theme/theme.dart';
import 'package:o18_web/utils/utils.dart';

class CountersTabView extends StatefulWidget {
  final TextEditingController textController;

  const CountersTabView({
    required this.textController,
  });

  @override
  State<CountersTabView> createState() => _CountersTabViewState();
}

class _CountersTabViewState extends State<CountersTabView> {
  @override
  Widget build(
    BuildContext context,
  ) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 40.w,
          vertical: 40.h,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  CounterString.counters,
                  style: AppFonts.heading_0,
                ),
                SizedBox(width: 11.w),
                RefreshButton(
                  onPressed: context.read<CountersTabCubit>().loadCounters,
                ),
                SizedBox(width: 170.w),
                SearchField(
                  title: CounterString.search,
                  textController: widget.textController,
                  onChanged: context.read<CountersTabCubit>().searchCounter,
                ),
                SizedBox(width: 60.w),
                const CurrentMonthCheckbox(),
              ],
            ),
            SizedBox(height: 34.h),
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(26.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CountersHeaderRow(),
                  SizedBox(
                    height: 728.h,
                    width: 1840.w,
                    child: BlocBuilder<CountersTabCubit, CountersTabState>(
                        builder: (context, state) {
                      if (state is CountersTabLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is CountersTabLoadFailed) {
                        return Center(
                          child: Text('${CounterString.error}: ${state.error}'),
                        );
                      } else if (state is CountersTabLoaded) {
                        if (state.list.isEmpty) {
                          return const Center(
                            child: Text(
                              CounterString.noCounters,
                            ),
                          );
                        }

                        return CounterListView(
                          list: state.list,
                        );
                      } else if (state is SearchingCounter) {
                        return CounterListView(
                          list: state.list,
                        );
                      } else if (state is CurrentMonth) {
                        return CounterListView(
                          list: state.list,
                        );
                      }

                      return const Center(
                        child: Text(
                          CounterString.noCounters,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
