import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:o18_web/features/houses_tab/cubit/cubit.dart';
import 'package:o18_web/features/houses_tab/widgets/widgets.dart';
import 'package:o18_web/theme/style/app_colors.dart';
import 'package:o18_web/theme/style/app_fonts.dart';
import 'package:o18_web/utils/utils.dart';

class AccountListView extends StatelessWidget {
  const AccountListView();

  @override
  Widget build(
    BuildContext context,
  ) =>
      BlocBuilder<AccountListCubit, AccountListState>(
          builder: (context, state) {
        if (state is AccountListInitial) {
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
                HouseString.chooseFlat,
                style: AppFonts.flatItemTitleGrey,
              ),
            ),
          );
        } else if (state is AccountListLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AccountListLoaded) {
          if (state.list.isEmpty) {
            return const Text(HouseString.noFlats);
          } else {
            if (state.list.isEmpty) {
              return const Text(HouseString.noAccounts);
            } else {
              return AccountList(list: state.list);
            }
          }
        } else if (state is AccountListLoadFailed) {
          return Text(state.error);
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      });
}
