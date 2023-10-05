part of 'account_list_cubit.dart';

abstract class AccountListState extends Equatable {
  const AccountListState();

  @override
  List<Object> get props => [];
}

class AccountListInitial extends AccountListState {}

class AccountListLoading extends AccountListState {}

class AccountListLoaded extends AccountListState {
  final List<Account> list;

  const AccountListLoaded(
    this.list,
  );

  @override
  List<Object> get props => [list];
}

class AccountListLoadFailed extends AccountListState {
  final String error;

  const AccountListLoadFailed(
    this.error,
  );

  @override
  List<Object> get props => [error];
}