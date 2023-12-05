// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:developer';

// ignore: implementation_imports, unused_import
import 'package:model_repository/src/model/models.dart' as model;
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class PartnerRepository {
  final int queryLimit = 1000000;

  Future<List<model.Partner>> getPartnerList() async {
    log(
      'getPartners() called',
      name: 'PartnerRepository: getPartnerList',
    );

    final QueryBuilder query = QueryBuilder<model.Partner>(model.Partner());
    query.setLimit(queryLimit);
    final q = await query.query();

    if (q.results != null) {
      final list = q.results!.map((dynamic partner) => partner as model.Partner).toList();
      list.sort((a, b) => a.title!.compareTo(b.title!));
      return list;
    }

    return [];
  }
}
