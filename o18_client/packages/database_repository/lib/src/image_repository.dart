import 'dart:developer';

// ignore: implementation_imports, unused_import
import 'package:model_repository/src/model/models.dart' as model;
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ImageRepository {
  final int queryLimit = 1000000;

  Future<List<model.ImageFile>> getImageListForRequestId({
    required String requestId,
  }) async {
    log(
      'getImageList() called',
      name: 'ImageRepository',
    );
    
    final QueryBuilder query = QueryBuilder<model.ImageFile>(model.ImageFile());
    query
      ..setLimit(queryLimit)
      ..whereEqualTo(model.ImageFile.keyRequestId, requestId);
    final q = await query.query();

    final qResults = q.results;
    if (qResults != null) {
      final list = qResults
          .map((dynamic imgageFile) => imgageFile as model.ImageFile)
          .toList();
      return list;
    }

    return [];
  }
}
