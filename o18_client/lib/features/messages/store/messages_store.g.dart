// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MessagesStore on _MessagesStoreBase, Store {
  late final _$messageListAtom =
      Atom(name: '_MessagesStoreBase.messageList', context: context);

  @override
  List<StaffMessage> get messageList {
    _$messageListAtom.reportRead();
    return super.messageList;
  }

  @override
  set messageList(List<StaffMessage> value) {
    _$messageListAtom.reportWrite(value, super.messageList, () {
      super.messageList = value;
    });
  }

  late final _$loadMessageListAsyncAction =
      AsyncAction('_MessagesStoreBase.loadMessageList', context: context);

  @override
  Future<void> loadMessageList({required String staffId}) {
    return _$loadMessageListAsyncAction
        .run(() => super.loadMessageList(staffId: staffId));
  }

  late final _$_MessagesStoreBaseActionController =
      ActionController(name: '_MessagesStoreBase', context: context);

  @override
  void searchRequest({required String query}) {
    final _$actionInfo = _$_MessagesStoreBaseActionController.startAction(
        name: '_MessagesStoreBase.searchRequest');
    try {
      return super.searchRequest(query: query);
    } finally {
      _$_MessagesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
messageList: ${messageList}
    ''';
  }
}
