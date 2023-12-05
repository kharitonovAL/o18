import 'dart:developer';

import 'package:auth_repository/auth_repository.dart';
import 'package:database_repository/database_repository.dart';
import 'package:model_repository/model_repository.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class AccountRepository {
  AccountRepository();

  static const int queryLimit = 1000000;

  Future<List<Account>> getAccountList() async {
    log(
      'getAccountList() called',
      name: 'AccountRepository',
    );
    final QueryBuilder query = QueryBuilder<Account>(Account());
    query.setLimit(queryLimit);
    final q = await query.query();

    final qResults = q.results;
    if (qResults != null) {
      final list = qResults.map((dynamic acc) => acc as Account).toList();

      return list;
    }

    throw 'getAccountList throw';
  }

  Future<List<Account>> getAccountListForFlat({
    required String flatId,
  }) async {
    log(
      'getAccountListForFlat() called',
      name: 'AccountRepository',
    );
    final QueryBuilder query = QueryBuilder<Account>(Account());
    query
      ..setLimit(queryLimit)
      ..whereEqualTo(Account.keyFlatId, flatId);

    final q = await query.query();
    final qResults = q.results;

    if (qResults != null) {
      final list = qResults.map((dynamic acc) => acc as Account).toList();

      return list;
    }

    throw 'getAccountListForFlat throw';
  }

  Future<List<Account>> getAccountsListByAddress({
    required String address,
    required String flatNumber,
    required HouseRepository houseRepository,
    required FlatRepository flatRepository,
  }) async {
    log(
      'getAccountsListByAddress() called',
      name: 'AccountRepository',
    );

    final housesList = await houseRepository.getHouseList();
    final house = housesList.firstWhere((house) => 'ул.${house.street}, д.${house.houseNumber}' == address);
    final flatList = await flatRepository.getFlatListForHouse(houseId: house.objectId!);
    final flat = flatList.firstWhere((flat) => flat.flatNumber == flatNumber);

    final accountList = await getAccountListForFlat(flatId: flat.objectId!);

    return accountList;
  }

  Future<Account> getAccountForCurrentUser({
    required AuthRepository authRepo,
    required OwnerRepository ownerRepository,
  }) async {
    log(
      'getAccountForCurrentUser() called',
      name: 'AccountRepository',
    );

    final user = await authRepo.currentUser();
    final owner = await ownerRepository.getOwnerByEmail(
      email: user!.emailAddress!,
    );
    final accountData = await getAccountByOwner(owner: owner!);

    return accountData;
  }

  Future<bool> isAccountExist({
    required House house,
    required String accountNumber,
    required FlatRepository flatRepository,
  }) async {
    var result = false;
    final flatList = await flatRepository.getFlatList();
    final accountList = await getAccountList();

    flatList.forEach((flat) => result = accountList.any((account) => account.accountNumber == accountNumber));

    return result;
  }

  Future<Account> getAccountByOwner({
    required Owner owner,
  }) async {
    log(
      'getAccountByOwner() called',
      name: 'AccountRepository',
    );
    final accountList = await getAccountList();
    final account = accountList.firstWhere((account) {
      final accOwnerIdList = account.ownerIdList;

      if (accOwnerIdList != null) {
        /// need to hard cast `e` to `String` because ParseServer objects doesn't support type safety
        final list = accOwnerIdList.map((dynamic e) => e as String).toList();

        return list.contains(owner.objectId);
      }
      throw 'getAccountByOwner throw';
    });

    return account;
  }

  Future<Account> getAccountByAccountNumber({
    required String accountNumber,
  }) async {
    log(
      'getAccountByOwner() called',
      name: 'AccountRepository',
    );
    final accountList = await getAccountList();
    final account = accountList.firstWhere((account) => account.accountNumber == accountNumber);

    return account;
  }
}
