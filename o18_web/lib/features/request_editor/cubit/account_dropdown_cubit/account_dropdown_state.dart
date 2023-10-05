part of 'account_dropdown_cubit.dart';

abstract class AccountDropdownState extends Equatable {
  const AccountDropdownState();

  @override
  List<Object> get props => [];
}

class AccountDropdownInitial extends AccountDropdownState {}

class AccountDataLoading extends AccountDropdownState {}

class AccountListLoaded extends AccountDropdownState {
  final List<Account> accountList;

  const AccountListLoaded({
    required this.accountList,
  });

  @override
  List<Object> get props => [accountList];
}

class AccountDataError extends AccountDropdownState {}
