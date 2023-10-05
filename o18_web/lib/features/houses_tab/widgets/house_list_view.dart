import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_web/features/houses_tab/cubit/cubit.dart';
import 'package:o18_web/features/houses_tab/view/house_detail_view.dart';
import 'package:o18_web/features/houses_tab/widgets/widgets.dart';

class HouseListView extends StatelessWidget {
  final List<House> list;
  final User user;

  const HouseListView({
    required this.list,
    required this.user,
  });

  @override
  Widget build(
    BuildContext context,
  ) =>
      ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (context, index) => HouseListItem(
          house: list[index],
          itemIndex: index,
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => FlatListCubit(
                      house: list[index],
                    ),
                  ),
                  BlocProvider(
                    create: (context) => AccountListCubit(),
                  ),
                  BlocProvider(
                    create: (context) => OwnerListCubit(),
                  ),
                ],
                child: HouseDetailView(
                  house: list[index],
                ),
              ),
            ),
          ),
        ),
      );
}
