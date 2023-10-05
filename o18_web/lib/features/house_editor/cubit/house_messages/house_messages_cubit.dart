import 'package:bloc/bloc.dart';
import 'package:database_repository/database_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:model_repository/model_repository.dart';

part 'house_messages_state.dart';

class HouseMessagesCubit extends Cubit<HouseMessagesState> {
  final House house;

  HouseMessagesCubit({
    required this.house,
  }) : super(HouseMessagesInitial()) {
    loadMessages();
  }

  final _messagesRepository = MessagesRepository();

  Future<void> loadMessages() async {
    emit(HouseMessagesLoading());

    final list = await _messagesRepository.getMessageListForHouse(
      houseId: house.objectId!,
    );

    emit(HouseMessagesLoaded(list));
  }
}
