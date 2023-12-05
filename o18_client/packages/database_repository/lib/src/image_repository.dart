import 'dart:developer';
import 'dart:io';

// ignore: implementation_imports, unused_import
import 'package:model_repository/model_repository.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class ImageRepository {
  static const int queryLimit = 1000000;

  Future<List<ImageFile>> getImageList() async {
    log(
      'getImageList() called',
      name: 'ImageFileRepository',
    );
    final QueryBuilder query = QueryBuilder<ImageFile>(ImageFile());
    query.setLimit(queryLimit);
    final q = await query.query();

    final qResults = q.results;
    if (qResults != null) {
      final list = qResults.map((dynamic imgageFile) => imgageFile as ImageFile).toList();
      return list;
    }

    throw 'getImageList throw';
  }

  Future<void> loadImage({
    required File image,
    required String requestId,
  }) async {
    ParseFileBase parseFile;

    final file = ParseWebFile(
      null,
      name: requestId,
      url: image.path,
    );
    await file.download();
    parseFile = ParseWebFile(
      file.file,
      name: file.name,
    );

    final _file = ImageFile();
    _file.set(ImageFile.keyRequestId, requestId);
    _file.set(ImageFile.keyFile, parseFile);
    await _file.save().then(
          (value) => log(
            'image load result: ${value.success}',
            name: 'ImageFileRepository',
          ),
        );
  }

  Future<List<ImageFile>> getImageListForRequestId({
    required String requestId,
  }) async {
    log(
      'getImageListForRequestId() called',
      name: 'ImageFileRepository',
    );
    final QueryBuilder query = QueryBuilder<ImageFile>(ImageFile());
    query
      ..setLimit(queryLimit)
      ..whereEqualTo(
        ImageFile.keyRequestId,
        requestId,
      );
    final q = await query.query();

    final qResults = q.results;
    if (qResults != null) {
      final list = qResults.map((dynamic imgageFile) => imgageFile as ImageFile).toList();
      return list;
    }

    throw 'getImageList throw';
  }
}
