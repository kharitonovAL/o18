// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class Owner extends ParseObject implements ParseCloneable {
  static const String _keyTableName = 'Owner';

  @override
  Owner clone(Map<String, dynamic> map) => Owner.clone()..fromJson(map);

  Owner() : super(_keyTableName);
  Owner.clone() : this();

  static const String keyObjectId = 'objectId';
  static const String keyAccountId = 'accountId';
  static const String keyEmail = 'email';
  static const String keyPhoneNumber = 'phoneNumber';
  static const String keyName = 'name';
  static const String keySquareMeters = 'squareMeters';
  static const String keyIsRegistered = 'isRegistered';
  static const String keyDeviceTokenList = 'deviceTokenList';

  @override
  String? get objectId => get<String>(keyObjectId);

  String? get accountId => get<String>(keyAccountId);
  set accountId(String? accountId) => set<String>(
        keyAccountId,
        accountId ?? '',
      );

  String? get email => get<String>(keyEmail);
  set email(String? email) => set<String>(
        keyEmail,
        email ?? '',
      );

  int? get phoneNumber => get<int>(keyPhoneNumber);
  set phoneNumber(int? phoneNumber) => set<int>(
        keyPhoneNumber,
        phoneNumber ?? 0,
      );

  String? get name => get<String>(keyName);
  set name(String? name) => set<String>(
        keyName,
        name ?? '',
      );

  double get squareMeters {
    final value = get<double>(keySquareMeters);
    return double.parse('$value');
  }

  set squareMeters(double squareMeters) => set<double>(
        keySquareMeters,
        squareMeters,
      );

  bool? get isRegistered => get<bool>(keyIsRegistered);
  set isRegistered(bool? isRegistered) => set<bool>(
        keyIsRegistered,
        isRegistered ?? false,
      );

  List? get deviceTokenList => get<List>(keyDeviceTokenList);
  set deviceTokenList(List? deviceTokenList) => set<List>(
        keyDeviceTokenList,
        deviceTokenList ?? <dynamic>[],
      );

  // This overrides needed to prevent DropdownButton from exception
  // on two same item
  @override
  int get hashCode => objectId.hashCode;

  @override
  bool operator ==(Object other) =>
      other is Owner && other.objectId == objectId;
}
