import 'package:bloc/bloc.dart';
import 'package:database_repository/database_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:model_repository/model_repository.dart';

part 'account_list_state.dart';

class AccountListCubit extends Cubit<AccountListState> {
  AccountListCubit() : super(AccountListInitial());

  String? flatId;
  final _accountRepository = AccountRepository();

  Future<void> loadAccountList({
    required String flatId,
  }) async {
    emit(AccountListLoading());

    final list = await _accountRepository.getAccountListForFlatById(
      flatId: flatId,
    );

    emit(AccountListLoaded(list));
  }

  Future<bool> saveChanges({
    required Account account,
    required String number,
    required double debt,
    required String? purpose,
  }) async {
    account
      ..accountNumber = number
      ..debt = debt
      ..purpose = purpose;

    final result = await account.update();

    return result.success;
  }
}
