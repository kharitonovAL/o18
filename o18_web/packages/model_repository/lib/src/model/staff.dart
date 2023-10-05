// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class Staff extends ParseObject implements ParseCloneable {
  static const String _keyTableName = 'PartnerStaff';

  @override
  Staff clone(Map<String, dynamic> map) => Staff.clone()..fromJson(map);

  Staff() : super(_keyTableName);
  Staff.clone() : this();

  static const String keyObjectId = 'objectId';
  static const String keyName = 'name';
  static const String keyPartnerId = 'partnerId';
  static const String keyPosition = 'position';
  static const String keyPhoneNumber = 'phoneNumber';
  static const String keyEmail = 'email';
  static const String keyIsRegistered = 'isRegistered';
  static const String keyDeviceToken = 'deviceToken';
  static const String keyRole = 'role';

  /// holds Parse DB object identificator
  @override
  String? get objectId => get<String>(keyObjectId);

  /// the staff's name, required thing
  String? get name => get<String>(keyName);
  set name(String? name) => set<String>(
        keyName,
        name ?? '',
      );

  /// the ID of the partner in Parse DB whom this staff belongs, required field
  String? get partnerId => get<String>(keyPartnerId);
  set partnerId(String? partnerId) => set<String>(
        keyPartnerId,
        partnerId ?? '',
      );

  /// the posin=tion title, for example: project manager, engineer
  String? get position => get<String>(keyPosition);
  set position(String? position) => set<String>(
        keyPosition,
        position ?? '',
      );

  /// staff's phone number
  String? get phoneNumber => get<String>(keyPhoneNumber);
  set phoneNumber(String? phoneNumber) => set<String>(
        keyPhoneNumber,
        phoneNumber ?? '',
      );

  /// staff's email, needed to register in CRM, required field
  String? get email => get<String>(keyEmail);
  set email(String? email) => set<String>(
        keyEmail,
        email ?? '',
      );

  bool? get isRegistered => get<bool>(keyIsRegistered);
  set isRegistered(bool? isRegistered) => set<bool>(
        keyIsRegistered,
        isRegistered ?? false,
      );

  String? get deviceToken => get<String>(keyDeviceToken);
  set deviceToken(String? deviceToken) => set<String>(
        keyDeviceToken,
        deviceToken ?? '',
      );

  /// staff can only have one of two roles: master or staff, required field
  String? get role => get<String>(keyRole);
  set role(String? role) => set<String>(
        keyRole,
        role ?? '',
      );

  // This overrides needed to prevent DropdownButton from exception
  // on two same item
  @override
  int get hashCode => objectId.hashCode;

  @override
  bool operator ==(Object other) => other is Staff && other.objectId == objectId;
}

class StaffRole {
  static const String master = 'Мастер';
  static const String staff = 'Исполнитель';

  static final List<String> list = [
    master,
    staff,
  ];
}
