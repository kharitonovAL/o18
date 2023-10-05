part of 'requests_tab_cubit.dart';

abstract class RequestsTabState extends Equatable {
  const RequestsTabState();

  @override
  List<Object> get props => [];
}

class RequestsTabInitial extends RequestsTabState {
  @override
  String toString() => 'RequestsTabInitial';
}

class UserRequestLoading extends RequestsTabState {
  @override
  String toString() => 'UserRequestLoading';
}

class UserRequestLoaded extends RequestsTabState {
  final List<UserRequest> userRequestList;

  const UserRequestLoaded(
    this.userRequestList,
  );

  @override
  String toString() => 'UserRequestLoadedSuccessfully';

  @override
  List<Object> get props => [userRequestList];
}

class UserRequestLoadFailure extends RequestsTabState {
  final String error;

  const UserRequestLoadFailure({
    required this.error,
  });

  @override
  String toString() => 'UserRequestLoadFailure { error: $error }';
}

class UserRequestAdded extends RequestsTabState {
  final List<UserRequest> userRequestList;

  const UserRequestAdded(
    this.userRequestList,
  );

  @override
  String toString() => 'UserRequestAdded';

  @override
  List<Object> get props => [userRequestList];
}

class SortFromOldToNew extends RequestsTabState {
  final List<UserRequest> userRequestList;

  const SortFromOldToNew(
    this.userRequestList,
  );

  @override
  String toString() => 'SortFromOldToNew';

  @override
  List<Object> get props => [userRequestList];
}

class SortFromNewToOld extends RequestsTabState {
  final List<UserRequest> userRequestList;

  const SortFromNewToOld(
    this.userRequestList,
  );

  @override
  String toString() => 'SortFromNewToOld';

  @override
  List<Object> get props => [userRequestList];
}

class SortFailureOnly extends RequestsTabState {
  final List<UserRequest> userRequestList;

  const SortFailureOnly(
    this.userRequestList,
  );

  @override
  String toString() => 'SortFailureOnly';

  @override
  List<Object> get props => [userRequestList];
}

class SearchchingRequest extends RequestsTabState {
  final List<UserRequest> userRequestList;

  const SearchchingRequest(
    this.userRequestList,
  );

  @override
  String toString() => 'SearchchingRequest';

  @override
  List<Object> get props => [userRequestList];
}
