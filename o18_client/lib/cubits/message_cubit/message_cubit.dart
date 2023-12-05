import 'dart:developer';

import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:database_repository/database_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:model_repository/model_repository.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  final MessagesRepository messagesRepository;
  final OwnerRepository ownerRepository;
  final AuthRepository authRepository;
  final String houseId;

  MessageCubit({
    required this.ownerRepository,
    required this.authRepository,
    required this.messagesRepository,
    required this.houseId,
  }) : super(MessageInitial()) {
    composeParseMessageList(houseId: houseId);
  }

  Future<void> composeParseMessageList({
    required String houseId,
  }) async {
    emit(MessageLoading());
    final list = await _loadMessages();

    if (list != null) {
      if (!isClosed) {
        emit(MessageLoaded(list));
      }
    } else {
      emit(
        const MessageLoadFailure(error: 'Ошибка загрузки сообщений'),
      );
    }
  }

  Future<void> updateMessage({
    required ParseMessage message,
  }) async {
    await messagesRepository.updateMessageWasSeenDate(message: message);

    emit(MessageLoading());
    final list = await _loadMessages();

    if (list != null) {
      emit(MessageWasRead(list));
    } else {
      emit(
        const MessageWasReadFailure(error: 'Дата просмотра сообщения не обновлена'),
      );
    }
  }

  Future<List<ParseMessage>?> _loadMessages() async {
    var resultList = <ParseMessage>[];
    var messagesForHouseList = <ParseMessage>[];
    var messagesForOwnerList = <ParseMessage>[];

    final user = await authRepository.currentUser();

    if (user != null) {
      final owner = await ownerRepository.getOwnerByEmail(email: user.emailAddress!);
      messagesForHouseList = await messagesRepository.getMessageListForHouse(houseId: houseId);
      messagesForOwnerList = await messagesRepository.getMessageListForOwner(ownerId: owner!.objectId!);
    } else {
      log('_loadMessages: user is null');
      return null;
    }

    if (messagesForHouseList.isEmpty && messagesForOwnerList.isEmpty) {
      return [];
    }

    resultList = messagesForHouseList;
    resultList.addAll(messagesForOwnerList);
    resultList.sort((a, b) => (b.date!).compareTo(a.date!));

    return resultList;
  }
}
