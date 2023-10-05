import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ParseMessage extends ParseObject implements ParseCloneable {
  static const String _keyTableName = 'Message';

  ParseMessage() : super(_keyTableName);
  ParseMessage.clone() : this();

  @override
  ParseMessage clone(Map<String, dynamic> map) =>
      ParseMessage.clone()..fromJson(map);

  static const String keyObjectId = 'objectId';
  static const String keyToken = 'token';
  static const String keyTitle = 'title';
  static const String keyBody = 'body';
  static const String keyDate = 'date';
  static const String keyWasSeen = 'wasSeen';
  static const String keyOwnerId = 'ownerId';
  static const String keyHouseId = 'houseId';
  static const String keyWasSeenDate = 'wasSeenDate';

  @override
  String? get objectId => get<String>(keyObjectId);

  String? get token => get<String>(keyToken);
  set token(String? token) => set<String>(
        keyToken,
        token ?? '',
      );

  String? get title => get<String>(keyTitle);
  set title(String? title) => set<String>(
        keyTitle,
        title ?? '',
      );

  String? get body => get<String>(keyBody);
  set body(String? body) => set<String>(
        keyBody,
        body ?? '',
      );

  DateTime? get date => get<DateTime>(keyDate);
  set date(DateTime? date) => set<DateTime>(
        keyDate,
        date ?? DateTime.now(),
      );

  DateTime? get wasSeenDate => get<DateTime>(keyWasSeenDate);
  set wasSeenDate(DateTime? wasSeenDate) => set<DateTime>(
        keyWasSeenDate,
        wasSeenDate ?? DateTime.now(),
      );

  bool? get wasSeen => get<bool>(keyWasSeen);
  set wasSeen(bool? wasSeen) => set<bool>(
        keyWasSeen,
        wasSeen ?? false,
      );

  String? get ownerId => get<String>(keyOwnerId);
  set ownerId(String? ownerId) => set<String>(
        keyOwnerId,
        ownerId ?? '',
      );

  String? get houseId => get<String>(keyHouseId);
  set houseId(String? houseId) => set<String>(
        keyHouseId,
        houseId ?? '',
      );
}
