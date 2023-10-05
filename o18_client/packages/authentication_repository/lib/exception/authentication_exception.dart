/// Thrown if during the sign in process if a failure occurs.
class AuthenticationException implements Exception {
  /// The associated error code.
  final int code;

  const AuthenticationException([
    this.code = -1,
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  /// https://parseplatform.org/Parse-SDK-dotNET/api/html/T_Parse_ParseException_ErrorCode.htm
  factory AuthenticationException.fromCode(int code) {
    switch (code) {
      case 1:
        return const AuthenticationException(1);
      case 100:
        return const AuthenticationException(100);
      case 101:
        return const AuthenticationException(101);
      case 119:
        return const AuthenticationException(119);

      default:
        return const AuthenticationException();
    }
  }
}

/// Thrown during the logout process if a failure occurs.
class LogoutExceptinon implements Exception {}
