import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class HouseMessage extends ParseObject implements ParseCloneable {
  static const String _keyTableName = 'HouseMessage';

  HouseMessage() : super(_keyTableName);
  HouseMessage.clone() : this();

  @override
  HouseMessage clone(Map<String, dynamic> map) =>
      HouseMessage.clone()..fromJson(map);

  static const String keyObjectId = 'objectId';
  static const String keyTitle = 'title';
  static const String keyBody = 'body';
  static const String keyDate = 'date';
  static const String keyHouseId = 'houseId';

  @override
  String? get objectId => get<String>(keyObjectId);

  String? get title => get<String>(keyTitle);
  set title(String? title) => set<String>(
        keyTitle,
        title ?? 'defaultValue',
      );

  String? get body => get<String>(keyBody);
  set body(String? body) => set<String>(
        keyBody,
        body ?? 'defaultValue',
      );

  DateTime? get date => get<DateTime>(keyDate);
  set date(DateTime? date) => set<DateTime>(
        keyDate,
        date ?? DateTime.now().toLocal(),
      );

  String? get houseId => get<String>(keyHouseId);
  set houseId(String? houseId) => set<String>(
        keyHouseId,
        houseId ?? 'defaultValue',
      );
}
