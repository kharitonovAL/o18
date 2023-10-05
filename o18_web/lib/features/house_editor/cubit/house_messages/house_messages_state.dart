part of 'house_messages_cubit.dart';

abstract class HouseMessagesState extends Equatable {
  const HouseMessagesState();

  @override
  List<Object> get props => [];
}

class HouseMessagesInitial extends HouseMessagesState {}

class HouseMessagesLoading extends HouseMessagesState {}

class HouseMessagesLoaded extends HouseMessagesState {
  final List<HouseMessage> list;

  const HouseMessagesLoaded(
    this.list,
  );

  @override
  List<Object> get props => [list];
}

class HouseMessagesLoadFailed extends HouseMessagesState {
  final String error;

  const HouseMessagesLoadFailed(
    this.error,
  );

  @override
  List<Object> get props => [error];
}
