import 'dart:async';
import 'dart:developer';

import 'package:authentication_repository/exception/authentication_exception.dart';
import 'package:authentication_repository/src/models/models.dart';
import 'package:cache/cache.dart';
import 'package:database_repository/database_repository.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

enum AuthenticationStatus {
  unknown,
  authenticated,
  unauthenticated,
}

class AuthenticationRepository {
  AuthenticationRepository({
    CacheClient? cache,
    OperatorRepository? operatorRepository,
  })  : _cache = cache ?? CacheClient(),
        _operatorRepository = operatorRepository ?? OperatorRepository();

  final CacheClient _cache;
  final OperatorRepository _operatorRepository;
  final _controller = StreamController<AuthenticationStatus>.broadcast();

  /// User cache key.
  /// Should only be used for testing purposes.
  static const userCacheKey = '__user_cache_key__';

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [User.empty] if the user is not authenticated.
  Stream<AuthenticationStatus> get user async* {
    yield await ParseUser.currentUser().then((dynamic user) {
      if ((user as ParseUser?) == null) {
        return AuthenticationStatus.unauthenticated;
      } else {
        // ignore: cast_nullable_to_non_nullable
        final currentUser = User.fromParseUser(parseUser: user as ParseUser);
        _cache.write<User>(key: userCacheKey, value: currentUser);

        return AuthenticationStatus.authenticated;
      }
    });

    yield* _controller.stream.asBroadcastStream();
  }

  /// Returns the current cached user.
  /// Defaults to [User.empty] if there is no cached user.
  User get currentUser => _cache.read<User>(key: userCacheKey) ?? User.empty;

  /// Signs in with the provided [email] and [password].
  /// Also get current user's role and check for it's permissions.
  ///
  /// Throws a [login] if an exception occurs.
  Future<void> login({
    required String email,
    required String password,
    required String userRole,
  }) async {
    try {
      final user = ParseUser(
        email,
        password,
        email,
      );

      final response = await user.login();

      if (response.results != null) {
        final loggedUser = User.fromParseUser(
          parseUser: response.results!.first as ParseUser,
        );

        // 0 check:
        // if user selected Operator role and user stored as operator
        // on server, or throw exception
        if (userRole == UserRole.mcOperator) {
          final userRoleIsOperator = await _userRoleIsOperator(
            email: loggedUser.email!,
          );

          if (userRoleIsOperator) {
            _cache.write<User>(key: userCacheKey, value: loggedUser);
            _controller.add(AuthenticationStatus.authenticated);

            log(
              'response is: ${response.success}, user is: $loggedUser, role: $userRole',
              name: 'AuthenticationRepository: login',
            );
          } else {
            log(
              'user is not an operator, access denied',
              name: 'AuthenticationRepository: login',
            );
            await logout();
            throw AuthenticationException.fromCode(119);
          }
        }
      } else {
        log(
          'response.results is null',
          name: 'AuthenticationRepository: login',
        );
        _controller.add(AuthenticationStatus.unauthenticated);
        throw AuthenticationException.fromCode(response.error?.code ?? -1);
      }

      if (!response.success) {
        log(
          'response.success is false',
          name: 'AuthenticationRepository: login',
        );
        _controller.add(AuthenticationStatus.unauthenticated);
        throw AuthenticationException.fromCode(response.error?.code ?? -1);
      }
    } on AuthenticationException catch (e) {
      throw AuthenticationException.fromCode(e.code);
    } catch (e) {
      log(e.toString(), name: 'AuthenticationRepository: login');

      throw const AuthenticationException();
    }
  }

  /// Creates a new staff user with the provided [email] and [password].
  ///
  /// Throws a [SignUpWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> signUpStaff({
    required String email,
    required String password,
  }) async {
    try {
      final user = ParseUser.createUser(
        email,
        password,
        email,
      );

      final response = await user.signUp();

      log(
        'response is: ${response.success}',
        name: 'AuthenticationRepository: signUpStaff',
      );

      if (!response.success) {
        throw AuthenticationException.fromCode(response.error?.code ?? -1);
      }
    } on AuthenticationException catch (e) {
      throw AuthenticationException.fromCode(e.code);
    } catch (_) {
      throw const AuthenticationException();
    }
  }

  Future<void> deleteUser({
    required String email,
  }) async {
    final response = await ParseUser.all();
    final userList = response.results!.map((e) => e as ParseUser).toList();
    final user = userList.firstWhere((u) => u.emailAddress == email);

    await user.destroy();
  }

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logout() async {
    try {
      final user = await ParseUser.currentUser() as ParseUser;
      final response = await user.logout();
      _controller.add(AuthenticationStatus.unauthenticated);

      log(
        'user logged out: ${response.success}',
        name: 'AuthenticationRepository: logout',
      );
    } catch (_) {
      throw LogoutExceptino();
    }
  }

  void dispose() {
    _controller.close();
  }

  Future<bool> _userRoleIsOperator({
    required String email,
  }) async {
    final list = await _operatorRepository.getOperatorList();
    return list.any((operator) => operator.email == email);
  }
}
