import 'dart:developer';

// ignore: implementation_imports
import 'package:model_repository/src/model/models.dart' as model;
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class UserRequestRepository {
  final int queryLimit = 1000000;

  Future<List<model.UserRequest>?> getUserRequestList() async {
    log(
      'getUserRequestList() called',
      name: 'getUserRequestList',
    );

    final QueryBuilder query =
        QueryBuilder<model.UserRequest>(model.UserRequest());
    query.setLimit(queryLimit);
    final q = await query.query();

    if (q.results != null) {
      final list = q.results!
          .map((dynamic request) => request as model.UserRequest)
          .toList();
      return list;
    }

    return null;
  }

  Future<QueryBuilder> getQuery() async {
    log(
      'getQuery() called',
      name: 'getUserRequestList',
    );

    final QueryBuilder query =
        QueryBuilder<model.UserRequest>(model.UserRequest());
    query.setLimit(queryLimit);

    return query;
  }
}
