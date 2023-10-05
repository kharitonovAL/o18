part of 'flat_list_cubit.dart';

abstract class FlatListState extends Equatable {
  const FlatListState();

  @override
  List<Object> get props => [];
}

class FlatListInitial extends FlatListState {}

class FlatListLoading extends FlatListState {}

class FlatListLoaded extends FlatListState {
  final List<Flat> list;

  const FlatListLoaded(
    this.list,
  );

  @override
  List<Object> get props => [list];
}

class FlatListLoadFailed extends FlatListState {
  final String error;

  const FlatListLoadFailed(
    this.error,
  );

  @override
  List<Object> get props => [error];
}

class FlatUpdated extends FlatListState {}

class FlatUpdateFailed extends FlatListState {
  final String error;

  const FlatUpdateFailed(
    this.error,
  );

  @override
  List<Object> get props => [error];
}