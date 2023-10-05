import 'package:o18_web/utils/utils.dart';

class AuthenticationExceptionMapper {
  static String fromCode(
    int code,
  ) {
    switch (code) {
      case 1:
        return LoginString.code_1;
      case 100:
        return LoginString.code_100;
      case 101:
        return LoginString.code_101;
      case 119:
        return LoginString.code_119;
      default:
        return LoginString.code_minus_1;
    }
  }
}
