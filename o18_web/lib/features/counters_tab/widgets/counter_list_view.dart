import 'package:flutter/material.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_web/features/counters_tab/widgets/widgets.dart';

class CounterListView extends StatelessWidget {
  final List<Counter> list;

  const CounterListView({
    required this.list,
  });

  @override
  Widget build(
    BuildContext context,
  ) =>
      ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (constext, index) => CounterListItem(
          counter: list[index],
          itemIndex: index,
        ),
      );
}
