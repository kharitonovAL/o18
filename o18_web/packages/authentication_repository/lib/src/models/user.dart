import 'package:equatable/equatable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

/// User model
///
/// [User.empty] represents an unauthenticated user.
class User extends Equatable {
  const User({
    required this.id,
    required this.email,
    required this.name,
  });

  /// The current user's email address.
  final String? email;

  /// The current user's id.
  final String id;

  /// The current user's name (display name).
  final String? name;

  /// Empty user which represents an unauthenticated user.
  static const empty = User(
    id: 'empty',
    email: 'empty',
    name: 'empty',
  );

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == User.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != User.empty;

  factory User.fromParseUser({
    required ParseUser parseUser,
  }) =>
      User(
        id: parseUser.objectId ?? 'empty',
        email: parseUser.emailAddress,
        name: parseUser.username,
      );

  @override
  List<Object?> get props => [
        email,
        id,
        name,
      ];
}
