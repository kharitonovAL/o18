import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class Operator extends ParseObject implements ParseCloneable {
  static const String _keyTableName = 'Operator';

  @override
  Operator clone(Map<String, dynamic> map) => Operator.clone()..fromJson(map);

  Operator() : super(_keyTableName);
  Operator.clone() : this();

  static const String keyDisplayName = 'displayName';
  static const String keyPhoneNumber = 'phoneNumber';
  static const String keyEmail = 'email';

  String? get name => get<String>(keyDisplayName);
  set name(String? displayName) => set<String>(
        keyDisplayName,
        displayName ?? 'displayName',
      );

  int? get phoneNumber => get<int>(keyPhoneNumber);
  set phoneNumber(int? phoneNumber) => set<int>(
        keyPhoneNumber,
        phoneNumber ?? 0,
      );

  String? get email => get<String>(keyEmail);
  set email(String? email) => set<String>(
        keyEmail,
        email ?? 'email',
      );
}
