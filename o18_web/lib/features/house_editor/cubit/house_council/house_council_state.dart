part of 'house_council_cubit.dart';

abstract class HouseCouncilState extends Equatable {
  const HouseCouncilState();

  @override
  List<Object> get props => [];
}

class HouseCouncilInitial extends HouseCouncilState {}

class HouseCouncilLoading extends HouseCouncilState {}

class HouseCouncilLoaded extends HouseCouncilState {
  final List<CouncilMember> list;

  const HouseCouncilLoaded(
    this.list,
  );

  @override
  List<Object> get props => [list];
}

class HouseCouncilAdded extends HouseCouncilState {}

class HouseCouncilAddFailed extends HouseCouncilState {
  final String error;

  const HouseCouncilAddFailed(
    this.error,
  );

  @override
  List<Object> get props => [error];
}

class HouseCouncilDeleted extends HouseCouncilState {}

class HouseCouncilDeleteFailed extends HouseCouncilState {
  final String error;

  const HouseCouncilDeleteFailed(
    this.error,
  );

  @override
  List<Object> get props => [error];
}

class HouseCouncilLoadFailed extends HouseCouncilState {
  final String error;

  const HouseCouncilLoadFailed(
    this.error,
  );

  @override
  List<Object> get props => [error];
}

class HouseCouncilUpdated extends HouseCouncilState {}

class HouseCouncilUpdateFailed extends HouseCouncilState {
  final String error;

  const HouseCouncilUpdateFailed(
    this.error,
  );

  @override
  List<Object> get props => [error];
}
