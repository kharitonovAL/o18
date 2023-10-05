import 'package:parse_server_sdk/parse_server_sdk.dart';

class RequestNumber extends ParseObject implements ParseCloneable {
  static const String _keyTableName = 'RequestNumber';

  RequestNumber() : super(_keyTableName);
  RequestNumber.clone() : this();

  @override
  RequestNumber clone(Map<String, dynamic> map) =>
      RequestNumber.clone()..fromJson(map);

  static const String keyRequestNumber = 'requestNumber';

  int? get requestNumber => get<int>(keyRequestNumber);
  set requestNumber(int? requestNumber) => set<int>(
        keyRequestNumber,
        requestNumber ?? 0,
      );
}
