import 'dart:async';
import 'dart:developer';

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

// enum AuthenticationStatus {
//   unknown,
//   authenticated,
//   unauthenticated,
// }

class AuthRepository {
  Future<ParseUser?> currentUser() async {
    final dynamic cachedUser = await ParseUser.currentUser();

    if (cachedUser != null) {
      final user = cachedUser as ParseUser;
      return user;
    }

    return null;
  }

  Future<ParseUser?> login({
    required String email,
    required String password,
  }) async {
    final user = ParseUser(
      email,
      password,
      email,
    );
    log(
      'method login, user is: $user',
      name: 'AuthenticationRepository',
    );

    final response = await user.login();
    log(
      'auth_service_parse.dart, method login, response is: ${response.success}',
      name: 'AuthenticationRepository',
    );

    if (response.success) {
      log(
        'user logged in with id: ${user.objectId}',
        name: 'AuthenticationRepository',
      );
      return user;
    } else {
      if (response.error != null) {
        log(
          'user login in error: ${response.error!.message}',
          name: 'AuthenticationRepository',
        );
      }
      return null;
    }
  }

  Future<ParseUser?> signUp({
    required String email,
    required String password,
  }) async {
    final user = ParseUser(email, password, email);
    log(
      'method signUp, user is: $user',
      name: 'AuthenticationRepository',
    );

    final response = await user.signUp();
    log(
      'auth_service_parse.dart, method signUp, user signUp: ${response.success}',
      name: 'AuthenticationRepository',
    );

    if (response.success) {
      log(
        'user signUp up with id: ${user.objectId}',
        name: 'AuthenticationRepository',
      );
      return user;
    } else {
      if (response.error != null) {
        log(
          'user login in error: ${response.error!.message}',
          name: 'AuthenticationRepository',
        );
      }
      return null;
    }
  }

  /// Signs out the current user.
  ///
  /// Throws a [LogoutExceptinon] if an exception occurs.
  Future<bool> logOut() async {
    try {
      final user = await ParseUser.currentUser() as ParseUser;
      final response = await user.logout();
      // _controller.add(AuthenticationStatus.unauthenticated);
      log(
        'user logged out: ${response.success}',
        name: 'AuthenticationRepository: logout',
      );

      return response.success;
    } catch (_) {
      throw LogoutExceptinon();
    }
  }
}

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
