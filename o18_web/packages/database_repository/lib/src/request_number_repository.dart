import 'dart:developer';

// ignore: implementation_imports, unused_import
import 'package:model_repository/src/model/models.dart' as model;
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class RequestNumberRepository {
  final int queryLimit = 1000000;

  Future<int> getLastRequestNumber() async {
    log(
      'getRequestNumbers() called',
      name: 'RequestNumberRepository',
    );

    final QueryBuilder query =
        QueryBuilder<model.RequestNumber>(model.RequestNumber());
    query.setLimit(queryLimit);
    final q = await query.query();

    final list = q.results == null
        ? <model.RequestNumber>[]
        : q.results!
            .map((dynamic reqNum) => reqNum as model.RequestNumber)
            .toList();
    log('${list.last.requestNumber}', name: 'getLastRequestNumber');
    return list.last.requestNumber!;
  }

  Future<bool> incrementRequestNumber() async {
    log(
      'incrementRequestNumbers() called',
      name: 'RequestNumberRepository',
    );
    final rn = model.RequestNumber();
    rn.requestNumber = await getLastRequestNumber() + 1;
    final response = await rn.save();
    return response.success;
  }
}
