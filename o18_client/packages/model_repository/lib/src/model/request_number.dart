import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class RequestNumber extends ParseObject implements ParseCloneable {
  static const String _keyTableName = 'RequestNumber';

  @override
  RequestNumber clone(Map<String, dynamic> map) =>
      RequestNumber.clone()..fromJson(map);

  RequestNumber() : super(_keyTableName);
  RequestNumber.clone() : this();

  static const String keyRequestNumber = 'requestNumber';

  int? get requestNumber => get<int>(keyRequestNumber);
  set requestNumber(int? requestNumber) => set<int>(
        keyRequestNumber,
        requestNumber ?? 0,
      );
}
