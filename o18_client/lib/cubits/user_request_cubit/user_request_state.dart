part of 'user_request_cubit.dart';

abstract class UserRequestState extends Equatable {
  const UserRequestState();

  @override
  List<Object> get props => [];
}

class UserRequestInitial extends UserRequestState {
  @override
  String toString() => 'UserRequestInitial';
}

class UserRequestLoading extends UserRequestState {
  @override
  String toString() => 'UserRequestLoading';
}

class UserRequestLoaded extends UserRequestState {
  final List<UserRequest> userRequestList;

  const UserRequestLoaded(this.userRequestList);

  @override
  String toString() => 'UserRequestLoadedSuccessfully';

  @override
  List<Object> get props => [userRequestList];
}

class UserRequestLoadFailure extends UserRequestState {
  final String error;

  const UserRequestLoadFailure({required this.error});

  @override
  String toString() => 'UserRequestLoadFailure { error: $error }';
}

class UserRequestAdded extends UserRequestState {
  final List<UserRequest> userRequestList;

  const UserRequestAdded(this.userRequestList);

  @override
  String toString() => 'UserRequestAdded';

  @override
  List<Object> get props => [userRequestList];
}
