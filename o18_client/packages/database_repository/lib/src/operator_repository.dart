import 'dart:developer';

// ignore: implementation_imports, unused_import
import 'package:model_repository/src/model/models.dart' as model;
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class OperatorRepository {
  final int queryLimit = 1000000;

  Future<List<model.Operator>> getOperatorList() async {
    log(
      'getOperatorsList() called',
      name: 'OperatorRepository: getOperatorList',
    );

    final QueryBuilder query = QueryBuilder<model.Operator>(model.Operator());
    query.setLimit(queryLimit);
    final q = await query.query();

    if (q.results != null) {
      final list = q.results!.map((dynamic operator) => operator as model.Operator).toList();
      list.sort((a, b) => a.name!.compareTo(b.name!));
      return list;
    }

    return [];
  }
}
