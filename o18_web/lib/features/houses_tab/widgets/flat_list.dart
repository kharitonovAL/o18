import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_web/features/houses_tab/cubit/cubit.dart';
import 'package:o18_web/features/houses_tab/widgets/widgets.dart';

class FlatList extends StatefulWidget {
  final List<Flat> list;

  const FlatList({
    required this.list,
  });

  @override
  State<FlatList> createState() => _FlatListState();
}

class _FlatListState extends State<FlatList> {
  int? _selectedIndex;

  @override
  Widget build(
    BuildContext context,
  ) =>
      ListView.separated(
        itemCount: widget.list.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => FlatListItem(
          flat: widget.list[index],
          itemIndex: index,
          selectedIndex: _selectedIndex,
          onTap: () async {
            setState(() => _selectedIndex = index);
            context.read<AccountListCubit>().flatId =
                widget.list[index].objectId!;
            context.read<OwnerListCubit>().clearOwner();
            await context.read<AccountListCubit>().loadAccountList(
                  flatId: widget.list[index].objectId!,
                );
          },
        ),
        separatorBuilder: (context, index) => SizedBox(
          height: 10.h,
        ),
        clipBehavior: Clip.none,
      );
}
