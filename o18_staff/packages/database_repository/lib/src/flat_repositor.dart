import 'dart:developer';

// ignore: implementation_imports, unused_import
import 'package:model_repository/src/model/models.dart' as model;
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class FlatRepository {
  final int queryLimit = 1000000;

  Future<List<model.Flat>> getFlatList() async {
    log(
      'getFlatList() called',
      name: 'FlatRepository',
    );

    final QueryBuilder query = QueryBuilder<model.Flat>(model.Flat());
    query.setLimit(queryLimit);
    final q = await query.query();
    final list = q.results == null
        ? <model.Flat>[]
        : q.results!.map((dynamic flat) => flat as model.Flat).toList();
    return list;
  }

  Future<List<model.Flat>> getFlatListForHouse({
    required String houseId,
  }) async {
    log(
      'getFlatListForHouse() called',
      name: 'FlatRepository',
    );

    final QueryBuilder query = QueryBuilder<model.Flat>(model.Flat());
    query
      ..setLimit(queryLimit)
      ..whereEqualTo(model.Flat.keyHouseId, houseId);

    final q = await query.query();
    final list = q.results == null
        ? <model.Flat>[]
        : q.results!.map((dynamic flat) => flat as model.Flat).toList();
    return list;
  }

  Future<bool> isFlatExist({
    required String houseId,
    required String flatNumber,
  }) async {
    log(
      'isFlatExist() called',
      name: 'FlatRepository',
    );

    final flatList = await getFlatListForHouse(houseId: houseId);
    return flatList.any((flat) => flat.flatNumber == flatNumber);
  }
}
