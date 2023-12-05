import 'dart:developer';

import 'package:model_repository/model_repository.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class FlatRepository {
  FlatRepository();

  static const int queryLimit = 1000000;

  Future<List<Flat>> getFlatList() async {
    log(
      'getFlatList() called',
      name: 'FlatRepository',
    );
    final QueryBuilder query = QueryBuilder<Flat>(Flat());
    query.setLimit(queryLimit);
    final q = await query.query();

    final qResults = q.results;

    if (qResults != null) {
      final list = qResults.map((dynamic flat) => flat as Flat).toList();
      return list;
    }
    throw 'getFlatList throw';
  }

  Future<List<Flat>> getFlatListForHouse({
    required String houseId,
  }) async {
    log(
      'getFlatListForHouse() called',
      name: 'FlatRepository',
    );
    final QueryBuilder query = QueryBuilder<Flat>(Flat());
    query
      ..setLimit(queryLimit)
      ..whereEqualTo(Flat.keyHouseId, houseId);

    final q = await query.query();
    final qResults = q.results;

    if (qResults != null) {
      final list = qResults.map((dynamic flat) => flat as Flat).toList();
      return list;
    }
    throw 'getFlatListForHouse throw';
  }

  Future<Flat?> getFlatByAccount({
    required String accountId,
  }) async {
    log(
      'getFlatByAccount() called',
      name: 'FlatRepository',
    );
    final flatList = await getFlatList();
    Flat? _flat;

    flatList.forEach((flat) {
      final tempFlatAccountIdList = flat.accountIdList;

      if (tempFlatAccountIdList != null) {
        final flatAccountIdList = tempFlatAccountIdList.map((dynamic id) => id as String).toList();
        if (flatAccountIdList.contains(accountId)) {
          _flat = flat;
        }
      }
    });
    return _flat;
  }
}
