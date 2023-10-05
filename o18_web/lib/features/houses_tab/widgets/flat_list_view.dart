import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_web/features/houses_tab/cubit/flat_list/flat_list_cubit.dart';
import 'package:o18_web/features/houses_tab/widgets/flat_list.dart';
import 'package:o18_web/utils/utils.dart';

class FlatListView extends StatelessWidget {
  final House house;

  const FlatListView({
    required this.house,
  });

  @override
  Widget build(
    BuildContext context,
  ) =>
      BlocBuilder<FlatListCubit, FlatListState>(builder: (context, state) {
        if (state is FlatListLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is FlatListLoaded) {
          if (state.list.isEmpty) {
            return const Text(HouseString.noFlats);
          } else {
            return FlatList(list: state.list);
          }
        } else if (state is FlatListLoadFailed) {
          return Text(state.error);
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      });
}
