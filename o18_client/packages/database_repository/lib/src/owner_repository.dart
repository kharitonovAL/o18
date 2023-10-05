// ignore_for_file: implementation_imports

import 'dart:developer';

import 'package:database_repository/src/account_repository.dart';
import 'package:database_repository/src/flat_repositor.dart';
import 'package:database_repository/src/house_repository.dart';
import 'package:model_repository/src/model/models.dart' as model;
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class OwnerRepository {
  final int queryLimit = 1000000;
  final houseRepository = HouseRepository();
  final accountRepository = AccountRepository();
  final flatRepository = FlatRepository();

  Future<List<model.Owner>> getOwnerList() async {
    log(
      'getOwnerList() called',
      name: 'OwnerRepository',
    );
    final QueryBuilder query = QueryBuilder<model.Owner>(model.Owner());
    query.setLimit(queryLimit);
    final q = await query.query();

    if (q.results != null) {
      final list = q.results!.map((dynamic owner) => owner as model.Owner).toList();
      return list;
    }
    return [];
  }

  Future<List<model.Owner>> loadOwnerListForAccount({
    required String accountNumber,
  }) async {
    log(
      'getOwnerListForAccount() called',
      name: 'OwnerRepository',
    );

    // get related account object [start]
    final QueryBuilder accountQuery = QueryBuilder<model.Account>(model.Account());
    accountQuery
      ..setLimit(queryLimit)
      ..whereEqualTo(model.Account.keyAccountNumber, accountNumber);
    final aq = await accountQuery.query();

    final accountList =
        aq.results == null ? <model.Account>[] : aq.results!.map((dynamic acc) => acc as model.Account).toList();
    final account = accountList.first;
    // get related account object [end]

    // get related owner objects [start]
    final QueryBuilder ownerQuery = QueryBuilder<model.Owner>(model.Owner());
    ownerQuery
      ..setLimit(queryLimit)
      ..whereEqualTo(model.Owner.keyAccountId, account.objectId);

    final oq = await ownerQuery.query();
    final ownerList =
        oq.results == null ? <model.Owner>[] : oq.results!.map((dynamic owner) => owner as model.Owner).toList();
    // get related owner objects [end]

    return ownerList;
  }

  Future<model.Owner?> getOwnerById({
    required String ownerId,
  }) async {
    log(
      'getOwnerById() called',
      name: 'OwnerRepository',
    );
    final response = await model.Owner().getObject(ownerId);
    if (response.results != null) {
      final owner = response.results!.first as model.Owner;
      return owner;
    }

    return null;
  }

  Future<String> getOwnerAddress({
    required model.Owner owner,
  }) async {
    log(
      'getOwnerAddress() called',
      name: 'OwnerRepository',
    );

    final accountList = await accountRepository.getAccountList();
    final account = accountList.firstWhere((account) => account.objectId == owner.accountId);

    final flatList = await flatRepository.getFlatList();
    final flat = flatList.firstWhere((flat) => flat.objectId == account.flatId);

    final houseList = await houseRepository.getHouseList();
    final house = houseList.firstWhere((house) => house.objectId == flat.houseId);

    final address = 'ул.${house.street}, д.${house.houseNumber}, кв.${flat.flatNumber}';
    return address;
  }
}
