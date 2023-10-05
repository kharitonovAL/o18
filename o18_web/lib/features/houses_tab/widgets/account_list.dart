import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_web/features/houses_tab/cubit/owner_list/owner_list_cubit.dart';
import 'package:o18_web/features/houses_tab/widgets/widgets.dart';

class AccountList extends StatefulWidget {
  final List<Account> list;

  const AccountList({
    required this.list,
  });

  @override
  State<AccountList> createState() => _AccountListState();
}

class _AccountListState extends State<AccountList> {
  int? _selectedIndex;

  @override
  Widget build(
    BuildContext context,
  ) =>
      ListView.separated(
        itemCount: widget.list.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => AccountListItem(
          account: widget.list[index],
          itemIndex: index,
          selectedIndex: _selectedIndex,
          onTap: () async {
            setState(() => _selectedIndex = index);
            context.read<OwnerListCubit>().accNumber =
                widget.list[index].accountNumber;
            await context.read<OwnerListCubit>().loadOwnerList(
                  accountNumber: widget.list[index].accountNumber!,
                );
          },
        ),
        separatorBuilder: (context, index) => SizedBox(
          height: 10.h,
        ),
        clipBehavior: Clip.none,
      );
}
