import 'package:bloc/bloc.dart';
import 'package:database_repository/database_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_web/utils/constants.dart';

part 'account_dropdown_state.dart';

class AccountDropdownCubit extends Cubit<AccountDropdownState> {
  final RequestSelection requestSelection;
  final UserRequest? userRequest;

  AccountDropdownCubit({
    this.requestSelection = RequestSelection.existedRequest,
    this.userRequest,
  }) : super(AccountDropdownInitial()) {
    if (requestSelection == RequestSelection.existedRequest) {
      loadAccountList(
        address: userRequest!.address!,
        flatNumber: userRequest!.flatNumber!,
      );
    }
  }

  final _accountRepository = AccountRepository();

  Future<void> loadAccountList({
    required String address,
    required String flatNumber,
  }) async {
    emit(AccountDataLoading());
    final accountList = await _accountRepository.getAccountsListByAddress(
      address: address,
      flatNumber: flatNumber,
    );

    accountList == null
        ? emit(AccountDataError())
        : emit(AccountListLoaded(
            accountList: accountList,
          ));
  }

  Future<void> clear() async => emit(AccountDropdownInitial());
}
