import 'package:database_repository/database_repository.dart';
import 'package:mobx/mobx.dart';
import 'package:model_repository/model_repository.dart';
part 'messages_store.g.dart';

class MessagesStore = _MessagesStoreBase with _$MessagesStore;

abstract class _MessagesStoreBase with Store {
  final _messagesRepository = MessagesRepository();

  List<StaffMessage> _messageList = [];

  @observable
  List<StaffMessage> messageList = [];

  @action
  Future<void> loadMessageList({
    required String staffId,
  }) async {
    _messageList = await _messagesRepository.getStaffMessageList(
      staffId: staffId,
    );

    messageList = _messageList;
  }

  @action
  void searchRequest({
    required String query,
  }) {
    final list = _messageList.toList();
    final searchResultList = <StaffMessage>[];

    // ignore: avoid_function_literals_in_foreach_calls
    list.forEach((m) {
      if (m.title!.toLowerCase().contains(query.toLowerCase()) || m.body!.toLowerCase().contains(query.toLowerCase())) {
        searchResultList.add(m);
      }
    });

    messageList = searchResultList;
  }

  Future<void> updateMessageDate({
    required StaffMessage message,
  }) async {
    await _messagesRepository.updateMessageWasSeenDate(
      message: message,
    );
  }
}
