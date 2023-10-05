// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RequestStore on _RequestStore, Store {
  late final _$userRequestListAtom =
      Atom(name: '_RequestStore.userRequestList', context: context);

  @override
  List<UserRequest> get userRequestList {
    _$userRequestListAtom.reportRead();
    return super.userRequestList;
  }

  @override
  set userRequestList(List<UserRequest> value) {
    _$userRequestListAtom.reportWrite(value, super.userRequestList, () {
      super.userRequestList = value;
    });
  }

  late final _$currentSortingAtom =
      Atom(name: '_RequestStore.currentSorting', context: context);

  @override
  String get currentSorting {
    _$currentSortingAtom.reportRead();
    return super.currentSorting;
  }

  @override
  set currentSorting(String value) {
    _$currentSortingAtom.reportWrite(value, super.currentSorting, () {
      super.currentSorting = value;
    });
  }

  late final _$loadUserRequestListAsyncAction =
      AsyncAction('_RequestStore.loadUserRequestList', context: context);

  @override
  Future<void> loadUserRequestList({required Staff staff}) {
    return _$loadUserRequestListAsyncAction
        .run(() => super.loadUserRequestList(staff: staff));
  }

  late final _$_RequestStoreActionController =
      ActionController(name: '_RequestStore', context: context);

  @override
  void sortFromOldToNew() {
    final _$actionInfo = _$_RequestStoreActionController.startAction(
        name: '_RequestStore.sortFromOldToNew');
    try {
      return super.sortFromOldToNew();
    } finally {
      _$_RequestStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void sortFromNewToOld() {
    final _$actionInfo = _$_RequestStoreActionController.startAction(
        name: '_RequestStore.sortFromNewToOld');
    try {
      return super.sortFromNewToOld();
    } finally {
      _$_RequestStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void sortFailureOnly() {
    final _$actionInfo = _$_RequestStoreActionController.startAction(
        name: '_RequestStore.sortFailureOnly');
    try {
      return super.sortFailureOnly();
    } finally {
      _$_RequestStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void searchRequest({required String query}) {
    final _$actionInfo = _$_RequestStoreActionController.startAction(
        name: '_RequestStore.searchRequest');
    try {
      return super.searchRequest(query: query);
    } finally {
      _$_RequestStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userRequestList: ${userRequestList},
currentSorting: ${currentSorting}
    ''';
  }
}
