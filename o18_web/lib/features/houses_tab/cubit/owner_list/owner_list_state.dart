part of 'owner_list_cubit.dart';

abstract class OwnerListState extends Equatable {
  const OwnerListState();

  @override
  List<Object> get props => [];
}

class OwnerListInitial extends OwnerListState {}

class OwnerListLoading extends OwnerListState {}

class OwnerListLoaded extends OwnerListState {
  final List<Owner> list;

  const OwnerListLoaded(
    this.list,
  );

  @override
  List<Object> get props => [list];
}

class OwnerListLoadFailed extends OwnerListState {
  final String error;

  const OwnerListLoadFailed(
    this.error,
  );

  @override
  List<Object> get props => [error];
}
