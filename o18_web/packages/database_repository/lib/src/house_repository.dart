import 'dart:developer';

// ignore: implementation_imports, unused_import
import 'package:model_repository/src/model/models.dart' as model;
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class HouseRepository {
  final int queryLimit = 1000000;

  Future<List<model.House>> getHouseList() async {
    log(
      'getHousesList() called',
      name: 'getHouseList',
    );
    
    final QueryBuilder query = QueryBuilder<model.House>(model.House());
    query.setLimit(queryLimit);
    final q = await query.query();

    if (q.results != null) {
      final list =
          q.results!.map((dynamic house) => house as model.House).toList();
      list.sort((a, b) => a.street!.compareTo(b.street!));
      return list;
    }

    return [];
  }
}
