// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class Account extends ParseObject implements ParseCloneable {
  static const String _keyTableName = 'Account';

  @override
  Account clone(Map<String, dynamic> map) => Account.clone()..fromJson(map);

  Account() : super(_keyTableName);
  Account.clone() : this();

  static const String keyObjectId = 'objectId';
  static const String keyAccountNumber = 'accountNumber';
  static const String keyDebt = 'debt';
  static const String keyPurpose = 'purpose';
  static const String keyOwnerIdList = 'ownerIdList';
  static const String keyFlatId = 'flatId';

  @override
  String? get objectId => get<String>(keyObjectId);

  String? get accountNumber => get<String>(keyAccountNumber);
  set accountNumber(String? accountNumber) => set<String>(
        keyAccountNumber,
        accountNumber ?? '',
      );

  double get debt {
    final value = get<double>(keyDebt);
    return double.parse('$value');
  }

  set debt(double debt) => set<double>(
        keyDebt,
        debt,
      );

  String? get purpose => get<String>(keyPurpose);
  set purpose(String? purpose) => set<String>(
        keyPurpose,
        purpose ?? AccountPurpose.common,
      );

  List? get ownerIdList => get<List>(keyOwnerIdList);
  set ownerIdList(List? ownerIdList) => set<List>(
        keyOwnerIdList,
        ownerIdList ?? <dynamic>[],
      );

  String? get flatId => get<String>(keyFlatId);
  set flatId(String? flatId) => set<String>(
        keyFlatId,
        flatId ?? '',
      );

  // This overrides needed to prevent DropdownButton from exception
  // on two same item
  @override
  int get hashCode => objectId.hashCode;

  @override
  bool operator ==(Object other) =>
      other is Account && other.objectId == objectId;
}

/// Describes flat's account purpose.
class AccountPurpose {
  /// Содержание и ремонт
  static const maintenanceAndRepair = 'Содержание и ремонт';

  /// Капитальный ремонт
  static const overhaul = 'Капитальный ремонт';

  /// Общий
  static const common = 'Общий';

  static final list = [maintenanceAndRepair, overhaul, common];
}
