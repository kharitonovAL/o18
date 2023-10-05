import 'package:parse_server_sdk/parse_server_sdk.dart';

class Account extends ParseObject implements ParseCloneable {
  static const String _keyTableName = 'Account';

  Account() : super(_keyTableName);
  Account.clone() : this();

  @override
  Account clone(Map<String, dynamic> map) => Account.clone()..fromJson(map);

  static const String keyObjectId = 'objectId';
  static const String keyAccountNumber = 'accountNumber';
  static const String keyDebt = 'debt';
  static const String keyPurpose = 'purpose';
  static const String keyOwnerIdList = 'ownerIdList';
  static const String keyFlatId = 'flatId';

  @override
  String? get objectId => get<String>(keyObjectId);

  String? get accountNumber => get<String>(keyAccountNumber);
  set accountNumber(String? accountNumber) => set<String>(keyAccountNumber, accountNumber ?? 'defaultValue');

  double? get debt {
    final value = get<dynamic>(keyDebt).toString();
    return double.parse(value);
  }

  set debt(double? debt) => set<double>(keyDebt, debt ?? 0);

  String? get purpose => get<String>(keyPurpose);
  set purpose(String? purpose) => set<String>(keyPurpose, purpose ?? 'defaultValue');

  /// need to leave `List` type because ParseServer objects doesn't support type safety
  List? get ownerIdList => get<List>(keyOwnerIdList);
  set ownerIdList(List? ownerIdList) => set<List>(keyOwnerIdList, ownerIdList ?? <dynamic>[]);

  String? get flatId => get<String>(keyFlatId);
  set flatId(String? flatId) => set<String>(keyFlatId, flatId ?? 'defaultValue');
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
