part of 'request_editor_cubit.dart';

abstract class RequestEditorState extends Equatable {
  const RequestEditorState();

  @override
  List<Object> get props => [];
}

class RequestEditorInitial extends RequestEditorState {}

class CreateNewRequest extends RequestEditorState {
  final int requestNumber;
  final List<UserRequest> requestList;
  final String operatorName;

  const CreateNewRequest(
    this.requestNumber,
    this.requestList,
    this.operatorName,
  );

  @override
  String toString() => 'CreateNewRequest';

  @override
  List<Object> get props => [
        requestNumber,
        requestList,
        operatorName,
      ];
}

class RequestDataLoading extends RequestEditorState {}

class RequestDataLoaded extends RequestEditorState {
  final UserRequest userRequest;
  final String operatorName;
  final List<UserRequest> requestList;
  final Address address;
  final Account account;
  final Owner owner;
  final Partner? partner;
  final Staff? master;
  final Staff? staff;

  const RequestDataLoaded({
    required this.userRequest,
    required this.operatorName,
    required this.requestList,
    required this.account,
    required this.address,
    required this.owner,
    this.partner,
    this.master,
    this.staff,
  });

  @override
  String toString() => 'RequestDataLoaded';

  @override
  List<Object> get props => [
        userRequest,
        operatorName,
        requestList,
      ];
}

class RequestDataLoadFailed extends RequestEditorState {
  final String error;

  const RequestDataLoadFailed(
    this.error,
  );

  @override
  String toString() => 'RequestDataLoadFailed';

  @override
  List<Object> get props => [error];
}

class RequestOperationSuccess extends RequestEditorState {}

class RequestOperationFailed extends RequestEditorState {
  final String error;

  const RequestOperationFailed({
    required this.error,
  });
}
