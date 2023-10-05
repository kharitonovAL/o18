import 'dart:developer';

// ignore: implementation_imports, unused_import
import 'package:model_repository/src/model/models.dart' as model;
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class CouncilRepository {
  final int queryLimit = 1000000;

  Future<List<model.CouncilMember>> getCouncilMemberList({
    required String houseId,
  }) async {
    log(
      'getCouncilMemberList() called',
      name: 'CouncilRepository',
    );
    
    final QueryBuilder query =
        QueryBuilder<model.CouncilMember>(model.CouncilMember());
    query.setLimit(queryLimit);
    final q = await query.query();
    final list = q.results == null
        ? <model.CouncilMember>[]
        : q.results!
            .map((dynamic member) => member as model.CouncilMember)
            .toList();
    list.retainWhere((member) => member.houseId == houseId);
    list.sort((a, b) => a.name!.compareTo(b.name!));
    return list;
  }
}
