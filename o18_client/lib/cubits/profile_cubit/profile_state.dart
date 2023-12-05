part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {
  @override
  String toString() => 'ProfileInitial';
}

class ProfileLoading extends ProfileState {
  @override
  String toString() => 'ProfileLoading';
}

class ProfileLoaded extends ProfileState {
  final UserProfile userProfile;
  final List<Account> accountList;
  final ParseUser parseUser;
  final Owner owner;
  final Account account;
  final Flat flat;
  final House house;

  const ProfileLoaded({
    required this.userProfile,
    required this.accountList,
    required this.parseUser,
    required this.owner,
    required this.account,
    required this.flat,
    required this.house,
  });

  @override
  String toString() => 'ProfileLoaded';

  @override
  List<Object> get props => [
        userProfile,
        accountList,
        parseUser,
        owner,
        account,
        flat,
        house,
      ];
}

class ProfileLoadFailure extends ProfileState {
  final String error;

  const ProfileLoadFailure({required this.error});

  @override
  String toString() => 'ProfileLoadFailure { error: $error }';

  @override
  List<Object> get props => [error];
}

class ProfileUserLogoutStarted extends ProfileState {
  @override
  String toString() => 'ProfileUserLogoutStarted';
}

class ProfileUserLoggedOut extends ProfileState {
  final bool isUserLoggedOut;

  const ProfileUserLoggedOut({required this.isUserLoggedOut});

  @override
  String toString() => 'ProfileUserLoggedOut';

  @override
  List<Object> get props => [isUserLoggedOut];
}

class ProfileUserLogoutFailure extends ProfileState {
  final String error;

  const ProfileUserLogoutFailure({required this.error});

  @override
  String toString() => 'ProfileUserLogoutFailure { error: $error }';

  @override
  List<Object> get props => [error];
}

class ProfileUserDeleteStarted extends ProfileState {
  @override
  String toString() => 'ProfileUserDeleteStarted';
}

class ProfileUserDeleted extends ProfileState {
  final bool isUserDeleted;

  const ProfileUserDeleted({required this.isUserDeleted});

  @override
  String toString() => 'ProfileUserDeleted';

  @override
  List<Object> get props => [isUserDeleted];
}

class ProfileUserDeleteFailure extends ProfileState {
  final String error;

  const ProfileUserDeleteFailure({required this.error});

  @override
  String toString() => 'ProfileUserDeleteFailure { error: $error }';

  @override
  List<Object> get props => [error];
}
