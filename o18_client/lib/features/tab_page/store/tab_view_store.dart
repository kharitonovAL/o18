import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'tab_view_store.g.dart';

class TabViewStore = _TabViewStore with _$TabViewStore;

abstract class _TabViewStore with Store {
  @observable
  int selectedIndex = 0;

  @action
  void onItemTapped({
    required PageController controller,
    required int index,
  }) {
    selectedIndex = index;
    controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }
}
