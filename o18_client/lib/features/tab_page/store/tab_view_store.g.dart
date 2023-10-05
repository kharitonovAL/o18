// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tab_view_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TabViewStore on _TabViewStore, Store {
  late final _$selectedIndexAtom =
      Atom(name: '_TabViewStore.selectedIndex', context: context);

  @override
  int get selectedIndex {
    _$selectedIndexAtom.reportRead();
    return super.selectedIndex;
  }

  @override
  set selectedIndex(int value) {
    _$selectedIndexAtom.reportWrite(value, super.selectedIndex, () {
      super.selectedIndex = value;
    });
  }

  late final _$_TabViewStoreActionController =
      ActionController(name: '_TabViewStore', context: context);

  @override
  void onItemTapped({required PageController controller, required int index}) {
    final _$actionInfo = _$_TabViewStoreActionController.startAction(
        name: '_TabViewStore.onItemTapped');
    try {
      return super.onItemTapped(controller: controller, index: index);
    } finally {
      _$_TabViewStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedIndex: ${selectedIndex}
    ''';
  }
}
