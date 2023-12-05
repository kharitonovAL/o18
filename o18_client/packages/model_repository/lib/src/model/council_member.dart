import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class CouncilMember extends ParseObject implements ParseCloneable {
  static const String _keyTableName = 'CouncilMember';

  @override
  CouncilMember clone(Map<String, dynamic> map) =>
      CouncilMember.clone()..fromJson(map);

  CouncilMember() : super(_keyTableName);
  CouncilMember.clone() : this();

  static const String keyObjectId = 'objectId';
  static const String keyName = 'name';
  static const String keyPhoneNumber = 'phoneNumber';
  static const String keyFlatNumber = 'flatNumber';
  static const String keyIsHousekeeper = 'isHousekeeper';
  static const String keyHouseId = 'houseId';

  @override
  String? get objectId => get<String>(keyObjectId);

  String? get name => get<String>(keyName);
  set name(String? name) => set<String>(
        keyName,
        name ?? '',
      );

  String? get phoneNumber => get<String>(keyPhoneNumber);
  set phoneNumber(String? phoneNumber) => set<String>(
        keyPhoneNumber,
        phoneNumber ?? '',
      );

  String? get flatNumber => get<String>(keyFlatNumber);
  set flatNumber(String? flatNumber) => set<String>(
        keyFlatNumber,
        flatNumber ?? '',
      );

  bool? get isHousekeeper => get<bool>(keyIsHousekeeper);
  set isHousekeeper(bool? isHousekeeper) => set<bool>(
        keyIsHousekeeper,
        isHousekeeper ?? false,
      );

  String? get houseId => get<String>(keyHouseId);
  set houseId(String? houseId) => set<String>(
        keyHouseId,
        houseId ?? '',
      );
}
