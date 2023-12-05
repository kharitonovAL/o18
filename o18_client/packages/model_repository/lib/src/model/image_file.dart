import 'package:flutter/foundation.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class ImageFile extends ParseObject implements ParseCloneable {
  static const String _keyTableName = 'Image';

  ImageFile() : super(_keyTableName);
  ImageFile.clone() : this();

  @override
  ImageFile clone(
    Map<String, dynamic> map,
  ) =>
      ImageFile.clone()..fromJson(map);

  static const String keyObjectId = 'objectId';
  static const String keyRequestId = 'requestId';
  static const String keyFile = 'file';

  @override
  String? get objectId => get<String>(keyObjectId);

  String? get requestId => get<String>(keyRequestId);
  set requestId(String? requestId) => set<String>(
        keyRequestId,
        requestId ?? 'default',
      );

  ParseFileBase? get file => kIsWeb ? get<ParseWebFile>(keyFile) : get<ParseFile>(keyFile);

  set file(dynamic file) => kIsWeb
      ? set<ParseWebFile>(
          keyFile,
          file as ParseWebFile,
        )
      : set<ParseFile>(
          keyFile,
          file as ParseFile,
        );
}
