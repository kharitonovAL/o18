import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class Flat extends ParseObject implements ParseCloneable {
  static const String _keyTableName = 'Flat';

  @override
  Flat clone(Map<String, dynamic> map) => Flat.clone()..fromJson(map);

  Flat() : super(_keyTableName);
  Flat.clone() : this();

  static const String keyObjectId = 'objectId';
  static const String keyFlatNumber = 'flatNumber';
  static const String keyFlatSquare = 'flatSquare';
  static const String keyNumberOfResidents = 'numberOfResidents';
  static const String keyAccountIdList = 'accountIdList';
  static const String keyCounterIdList = 'counterIdList';
  static const String keyHouseId = 'houseId';
  static const String keyPurpose = 'purpose';

  @override
  String? get objectId => get<String>(keyObjectId);

  String? get flatNumber => get<String>(keyFlatNumber);
  set flatNumber(String? flatNumber) => set<String>(
        keyFlatNumber,
        flatNumber ?? '',
      );

  double? get flatSquare => get<double>(keyFlatSquare);
  set flatSquare(double? flatSquare) => set<double>(
        keyFlatSquare,
        flatSquare ?? 0,
      );

  int? get numberOfResidents => get<int>(keyNumberOfResidents);
  set numberOfResidents(int? numberOfResidents) => set<int>(
        keyNumberOfResidents,
        numberOfResidents ?? 0,
      );

  List? get accountIdList => get<List>(keyAccountIdList);
  set accountIdList(List? accountIdList) => set<List>(
        keyAccountIdList,
        accountIdList ?? <dynamic>[],
      );

  List? get counterIdList => get<List>(keyCounterIdList);
  set counterIdList(List? counterIdList) => set<List>(
        keyCounterIdList,
        counterIdList ?? <dynamic>[],
      );

  String? get houseId => get<String>(keyHouseId);
  set houseId(String? houseId) => set<String>(
        keyHouseId,
        houseId ?? '',
      );

  String? get purpose => get<String>(keyPurpose);
  set purpose(String? purpose) => set<String>(
        keyPurpose,
        purpose ?? FlatPurpose.living,
      );
}

class FlatPurpose {
  /// Жилое
  static const living = 'Жилое';

  /// Нежилое
  static const nonResidential = 'Нежилое';

  static final list = [living, nonResidential];
}
