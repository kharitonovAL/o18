import 'package:parse_server_sdk/parse_server_sdk.dart';

class Flat extends ParseObject implements ParseCloneable {
  static const String _keyTableName = 'Flat';

  Flat() : super(_keyTableName);
  Flat.clone() : this();

  @override
  Flat clone(Map<String, dynamic> map) => Flat.clone()..fromJson(map);

  static const String keyObjectId = 'objectId';
  static const String keyFlatNumber = 'flatNumber';
  static const String keyFlatSquare = 'flatSquare';
  static const String keyNumberOfResidents = 'numberOfResidents';
  static const String keyAccountIdList = 'accountIdList';
  static const String keyCounterIdList = 'counterIdList';
  static const String keyHouseId = 'houseId';

  @override
  String? get objectId => get<String>(keyObjectId);

  String? get flatNumber => get<String>(keyFlatNumber);
  set flatNumber(String? flatNumber) => set<String>(
        keyFlatNumber,
        flatNumber ?? 'defaultValue',
      );

  double? get flatSquare {
    final value = get<double>(keyFlatSquare);
    return double.parse('$value');
  }

  set flatSquare(double? flatSquare) => set<double>(
        keyFlatSquare,
        flatSquare ?? 0,
      );

  int? get numberOfResidents => get<int>(keyNumberOfResidents);
  set numberOfResidents(int? numberOfResidents) => set<int>(
        keyNumberOfResidents,
        numberOfResidents ?? 0,
      );

  /// need to leave `List` type because ParseServer objects doesn't support type safety
  List? get accountIdList => get<List>(keyAccountIdList);
  set accountIdList(List? accountIdList) => set<List>(
        keyAccountIdList,
        accountIdList ?? <dynamic>[],
      );

  /// need to leave `List` type because ParseServer objects doesn't support type safety
  List? get counterIdList => get<List>(keyCounterIdList);
  set counterIdList(List? counterIdList) => set<List>(
        keyCounterIdList,
        counterIdList ?? <dynamic>[],
      );

  String? get houseId => get<String>(keyHouseId);
  set houseId(String? houseId) => set<String>(
        keyHouseId,
        houseId ?? 'defaultValue',
      );
}
