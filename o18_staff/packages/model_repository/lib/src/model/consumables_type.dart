import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ConsumablesType extends ParseObject implements ParseCloneable {
  static const String _keyTableName = 'ConsumablesType';

  @override
  ConsumablesType clone(Map<String, dynamic> map) =>
      ConsumablesType.clone()..fromJson(map);

  ConsumablesType() : super(_keyTableName);
  ConsumablesType.clone() : this();

  static const String keyTitle = 'title';

  String? get title => get<String>(keyTitle);
  set title(String? title) => set<String>(
        keyTitle,
        title ?? 'defaultValue',
      );
}
