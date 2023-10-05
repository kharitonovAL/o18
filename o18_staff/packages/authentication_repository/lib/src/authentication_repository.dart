import 'dart:async';
import 'dart:developer';

import 'package:authentication_repository/exception/authentication_exception.dart';
import 'package:database_repository/database_repository.dart';
import 'package:model_repository/model_repository.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

enum AuthenticationStatus {
  unknown,
  authenticated,
  unauthenticated,
}

class StaffRole {
  static const String master = 'Мастер';
  static const String staff = 'Исполнитель';

  static final List<String> list = [
    master,
    staff,
  ];
}

class AuthenticationRepository {
  final _staffRepository = StaffRepository();

  /// Signs in with the provided [email] and [password].
  /// Also get current user's role and check for it's permissions.
  ///
  /// Throws a [login] if an exception occurs.
  Future<Staff?> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = ParseUser(
        email,
        password,
        email,
      );

      final response = await user.login();

      if (response.results != null) {
        final loggedUser = response.results!.first as ParseUser;

        // prepare data to be managed later
        final staffList = await _staffRepository.getStaffList();

        // match logged user and ifo about him from Parse
        final staff = staffList.firstWhere((s) => s.email == loggedUser.emailAddress);

        if (staff.isRegistered != null) {
          if (staff.isRegistered!) {
            log(
              'response is: ${response.success}, user is: $loggedUser, role: ${staff.role}',
              name: 'AuthenticationRepository: login',
            );

            return staff;
          } else {
            log(
              'staff is not registered, access denied',
              name: 'AuthenticationRepository: login',
            );
            await logout();
            throw AuthenticationException.fromCode(119);
          }
        } else {
          log(
            'staff registratinon is null',
            name: 'AuthenticationRepository: login',
          );
          throw const AuthenticationException();
        }
      } else {
        log(
          'response.results is null',
          name: 'AuthenticationRepository: login',
        );
        throw AuthenticationException.fromCode(response.error?.code ?? -1);
      }
    } on AuthenticationException catch (e) {
      throw AuthenticationException.fromCode(e.code);
    } catch (e) {
      log(e.toString(), name: 'AuthenticationRepository: login');
      throw const AuthenticationException();
    }
  }

  /// Signs out the current user.
  ///
  /// Throws a [LogoutExceptinon] if an exception occurs.
  Future<bool> logout() async {
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
