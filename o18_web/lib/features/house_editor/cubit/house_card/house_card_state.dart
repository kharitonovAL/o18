part of 'house_card_cubit.dart';

abstract class HouseCardState extends Equatable {
  const HouseCardState();

  @override
  List<Object> get props => [];
}

class HouseCardInitial extends HouseCardState {}

class HouseOperationSuccess extends HouseCardState {}

class HouseOperationFailed extends HouseCardState {
  final String error;

  const HouseOperationFailed({
    required this.error,
  });

  @override
  String toString() => 'HouseOperationFailed';

  @override
  List<Object> get props => [error];
}
