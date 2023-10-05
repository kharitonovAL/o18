import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class Consumable extends ParseObject implements ParseCloneable {
  static const String _keyTableName = 'Consumable';

  @override
  Consumable clone(Map<String, dynamic> map) =>
      Consumable.clone()..fromJson(map);

  Consumable() : super(_keyTableName);
  Consumable.clone() : this();

  static const String keyTitle = 'title';
  static const String keyDescription = 'description';
  static const String keyConsumableType = 'consumableType';
  static const String keyPrice = 'price';
  static const String keyWarehouse = 'warehouse';
  static const String keyUnit = 'unit';
  static const String keyBalance = 'balance';

  String? get title => get<String>(keyTitle);
  set title(String? title) => set<String>(
        keyTitle,
        title ?? 'defaultValue',
      );

  String? get description => get<String>(keyDescription);
  set description(String? description) => set<String>(
        keyDescription,
        description ?? 'defaultValue',
      );

  String? get consumableType => get<String>(keyConsumableType);
  set consumableType(String? consumableType) => set<String>(
        keyConsumableType,
        consumableType ?? 'defaultValue',
      );

  double? get price => get<double>(keyPrice);
  set price(double? price) => set<double>(
        keyPrice,
        price ?? 0,
      );

  String? get warehouse => get<String>(keyWarehouse);
  set warehouse(String? warehouse) => set<String>(
        keyWarehouse,
        warehouse ?? 'defaultValue' ,
      );

  String? get unit => get<String>(keyUnit);
  set unit(String? unit) => set<String>(
        keyUnit,
        unit ?? 'defaultValue',
      );

  double? get balance => get<double>(keyBalance);
  set balance(double? balance) => set<double>(
        keyBalance,
        balance ?? 0,
      );
}
