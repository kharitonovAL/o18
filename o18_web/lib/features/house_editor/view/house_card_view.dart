import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_web/features/house_editor/cubit/cubit.dart';
import 'package:o18_web/features/house_editor/widgets/widgets.dart';
import 'package:o18_web/features/houses_tab/cubit/cubit.dart';
import 'package:o18_web/theme/theme.dart';
import 'package:o18_web/utils/utils.dart';

class HouseCardView extends StatelessWidget {
  final House house;

  const HouseCardView({
    required this.house,
  });

  @override
  Widget build(
    BuildContext context,
  ) =>
      Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            HouseString.houseEditor,
            style: AppFonts.editorTitle,
          ),
          shadowColor: Colors.transparent,
          leading: GestureDetector(
            onTap: Navigator.of(context).pop,
            child: Padding(
              padding: EdgeInsets.only(
                left: 24.w,
                top: 24.h,
                bottom: 24.h,
              ),
              child: Icon(
                Icons.arrow_back,
                size: 28.w,
                color: AppColors.green_0,
              ),
            ),
          ),
        ),
        body: BlocBuilder<HouseCardCubit, HouseCardState>(
          builder: (context, state) {
            if (state is HouseCardInitial) {
              return HouseCardForm(
                house: house,
              );
            } else if (state is HouseOperationSuccess) {
              context.read<HousesTabCubit>().loadHousesList();
            } else if (state is HouseOperationFailed) {
              return Center(
                child: Text(state.error.toString()),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      );
}
