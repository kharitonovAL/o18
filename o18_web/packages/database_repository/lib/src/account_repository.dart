// ignore_for_file: implementation_imports

import 'dart:developer';

import 'package:database_repository/src/flat_repositor.dart';
import 'package:database_repository/src/house_repository.dart';
import 'package:model_repository/src/model/models.dart' as model;
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class AccountRepository {
  final int queryLimit = 1000000;
  final houseRepository = HouseRepository();
  final flatRepository = FlatRepository();

  Future<List<model.Account>> getAccountList() async {
    log(
      'getAccountList() called',
      name: 'AccountRepository',
    );

    final QueryBuilder query = QueryBuilder<model.Account>(model.Account());
    query.setLimit(queryLimit);
    final q = await query.query();
    final list = q.results == null
        ? <model.Account>[]
        : q.results!.map((dynamic acc) => acc as model.Account).toList();
    return list;
  }

  Future<List<model.Account>> getAccountListForFlatById({
    required String flatId,
  }) async {
    log(
      'getAccountList() called',
      name: 'AccountRepository',
    );

    final QueryBuilder query = QueryBuilder<model.Account>(model.Account());
    query
      ..setLimit(queryLimit)
      ..whereEqualTo(model.Account.keyFlatId, flatId);

    final q = await query.query();
    final list = q.results == null
        ? <model.Account>[]
        : q.results!.map((dynamic acc) => acc as model.Account).toList();
    return list;
  }

  Future<List<model.Account>?> getAccountsListByAddress({
    required String address,
    required String flatNumber,
  }) async {
    log(
      'getAccountsListByAddress() called',
      name: 'AccountRepository',
    );

    // check if input data exist
    if (address.trim().isEmpty || flatNumber.trim().isEmpty) {
      return null;
    }

    final housesList = await houseRepository.getHouseList();
    final house = housesList.firstWhere(
      (house) => 'улица ${house.street}, ${house.houseNumber}' == address,
    );
    final flatList = await flatRepository.getFlatListForHouse(
      houseId: house.objectId!,
    );

    if (flatList.any((f) => f.flatNumber == flatNumber)) {
      final flat = flatList.firstWhere(
        (flat) => flat.flatNumber == flatNumber,
      );
      final accountList = await getAccountListForFlatById(
        flatId: flat.objectId!,
      );

      return accountList;
    }

    return null;
  }

  Future<bool> isAccountExist({
    required String houseId,
    required String accountNumber,
  }) async {
    log(
      'isAccountExist() called',
      name: 'AccountRepository',
    );

    final accountList = await getAccountList();
    return accountList.any((account) => account.accountNumber == accountNumber);
  }
}
