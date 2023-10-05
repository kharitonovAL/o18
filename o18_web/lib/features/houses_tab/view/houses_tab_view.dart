import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:o18_web/features/houses_tab/cubit/cubit.dart';
import 'package:o18_web/features/houses_tab/widgets/widgets.dart';
import 'package:o18_web/features/widgets/widgets.dart';
import 'package:o18_web/theme/theme.dart';
import 'package:o18_web/utils/utils.dart';

class HousesTabView extends StatelessWidget {
  final TextEditingController textController;
  final User user;

  const HousesTabView({
    required this.textController,
    required this.user,
  });

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      HouseString.houses,
                      style: AppFonts.heading_0,
                    ),
                    SizedBox(width: 11.w),
                    RefreshButton(
                      onPressed: context.read<HousesTabCubit>().loadHousesList,
                    ),
                  ],
                ),
                SearchField(
                  title: HouseString.search,
                  textController: textController,
                  onChanged: context.read<HousesTabCubit>().searchHouse,
                ),
              ],
            ),
            SizedBox(height: 34.h),
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(26.r),
              ),
              child: Column(
                children: [
                  const HouseHeaderRow(),
                  SizedBox(
                    height: 740.h,
                    width: 1840.w,
                    child: BlocBuilder<HousesTabCubit, HousesTabState>(
                      builder: (context, state) {
                        if (state is HousesLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is HousesLoadFailure) {
                          return Center(
                            child: Text('${HouseString.error}: ${state.error}'),
                          );
                        } else if (state is HousesLoaded) {
                          if (state.houseList.isEmpty) {
                            return const Center(
                              child: Text(
                                HouseString.noHouses,
                              ),
                            );
                          }

                          return HouseListView(
                            list: state.houseList,
                            user: user,
                          );
                        } else if (state is SearchingHouse) {
                          return HouseListView(
                            list: state.houseList,
                            user: user,
                          );
                        }

                        return const Center(
                          child: Text(
                            HouseString.noHouses,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
