import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_web/features/houses_tab/widgets/widgets.dart';

class OwnerList extends StatefulWidget {
  final List<Owner> list;

  const OwnerList({
    required this.list,
  });

  @override
  State<OwnerList> createState() => _OwnerListState();
}

class _OwnerListState extends State<OwnerList> {
  int? _selectedIndex;

  @override
  Widget build(
    BuildContext context,
  ) =>
      ListView.separated(
        itemCount: widget.list.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => OwnerListItem(
          owner: widget.list[index],
          itemIndex: index,
          selectedIndex: _selectedIndex,
        ),
        separatorBuilder: (context, index) => SizedBox(
          height: 10.h,
        ),
        clipBehavior: Clip.none,
      );
}
