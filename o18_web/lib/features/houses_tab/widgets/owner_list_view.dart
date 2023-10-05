import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:o18_web/features/houses_tab/cubit/cubit.dart';
import 'package:o18_web/features/houses_tab/widgets/widgets.dart';
import 'package:o18_web/theme/theme.dart';
import 'package:o18_web/utils/utils.dart';

class OwnerListView extends StatelessWidget {
  const OwnerListView();

  @override
  Widget build(
    BuildContext context,
  ) =>
      BlocBuilder<OwnerListCubit, OwnerListState>(builder: (context, state) {
        if (state is OwnerListInitial) {
          return Container(
            height: 90.h,
            width: 587.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: AppColors.grey_8,
              ),
            ),
            child: Center(
              child: Text(
                HouseString.chooseAccount,
                style: AppFonts.flatItemTitleGrey,
              ),
            ),
          );
        } else if (state is OwnerListLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is OwnerListLoaded) {
          if (state.list.isEmpty) {
            return const Text(HouseString.noOwners);
          } else {
            if (state.list.isEmpty) {
              return const Text(HouseString.noOwners);
            } else {
              return OwnerList(list: state.list);
            }
          }
        } else if (state is OwnerListLoadFailed) {
          return Text(state.error);
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      });
}
