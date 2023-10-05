import 'package:parse_server_sdk/parse_server_sdk.dart';

class ImageFile extends ParseObject implements ParseCloneable {
  static const String _keyTableName = 'Image';

  ImageFile() : super(_keyTableName);
  ImageFile.clone() : this();

  @override
  ImageFile clone(Map<String, dynamic> map) => ImageFile.clone()..fromJson(map);

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

  ParseFile? get file => get<ParseFile>(keyFile);
  set file(ParseFile? file) => set<ParseFile>(keyFile, file!);
}
