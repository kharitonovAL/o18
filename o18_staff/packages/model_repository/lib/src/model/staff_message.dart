import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class StaffMessage extends ParseObject implements ParseCloneable {
  static const String _keyTableName = 'StaffMessage';

  StaffMessage() : super(_keyTableName);
  StaffMessage.clone() : this();

  @override
  StaffMessage clone(Map<String, dynamic> map) =>
      StaffMessage.clone()..fromJson(map);

  static const String keyObjectId = 'objectId';
  static const String keyTitle = 'title';
  static const String keyBody = 'body';
  static const String keyDate = 'date';
  static const String keyStaffId = 'staffId';
  static const String keyWasSeen = 'wasSeen';
  static const String keyWasSeenDate = 'wasSeenDate';

  @override
  String? get objectId => get<String>(keyObjectId);

  String? get title => get<String>(keyTitle);
  set title(String? title) => set<String>(
        keyTitle,
        title ?? 'title',
      );

  String? get body => get<String>(keyBody);
  set body(String? body) => set<String>(
        keyBody,
        body ?? 'body',
      );

  DateTime? get date => get<DateTime>(keyDate);
  set date(DateTime? date) => set<DateTime>(
        keyDate,
        date ?? DateTime.now().toLocal(),
      );

  String? get staffId => get<String>(keyStaffId);
  set staffId(String? staffId) => set<String>(
        keyStaffId,
        staffId ?? 'staffId',
      );

  DateTime? get wasSeenDate => get<DateTime>(keyWasSeenDate);
  set wasSeenDate(DateTime? wasSeenDate) => set<DateTime>(
        keyWasSeenDate,
        wasSeenDate ?? DateTime.now().toLocal(),
      );

  bool? get wasSeen => get<bool>(keyWasSeen);
  set wasSeen(bool? wasSeen) => set<bool>(
        keyWasSeen,
        wasSeen ?? false,
      );
}
