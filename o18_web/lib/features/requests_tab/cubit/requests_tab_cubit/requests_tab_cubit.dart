import 'package:bloc/bloc.dart';
import 'package:database_repository/database_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_web/utils/errors.dart';

part 'requests_tab_state.dart';

class RequestsTabCubit extends Cubit<RequestsTabState> {
  RequestsTabCubit() : super(RequestsTabInitial()) {
    loadUserRequestList();
  }

  List<UserRequest> requestList = [];
  final _userRequestRepository = UserRequestRepository();

  Future<void> loadUserRequestList() async {
    emit(UserRequestLoading());
    final list = await _userRequestRepository.getUserRequestList();
    if (list != null) {
      list.sort((a, b) => a.requestNumber!.compareTo(b.requestNumber!));
      emit(UserRequestLoaded(list.reversed.toList()));

      requestList = list.toList();
    } else {
      emit(const UserRequestLoadFailure(
        error: ErrorText.loadFailure,
      ));
    }
  }

  void sortFromOldToNew() {
    final list = requestList.toList();
    list.sort((a, b) => a.requestNumber!.compareTo(b.requestNumber!));
    emit(SortFromOldToNew(list));
  }

  void sortFromNewToOld() {
    final list = requestList.toList();
    list.sort((a, b) => a.requestNumber!.compareTo(b.requestNumber!));
    emit(SortFromNewToOld(list.reversed.toList()));
  }

  void sortFailureOnly() {
    final list = requestList.toList();
    list.retainWhere((r) => r.requestType == RequestType.failure);
    list.sort((a, b) => a.requestNumber!.compareTo(b.requestNumber!));
    emit(SortFailureOnly(list.reversed.toList()));
  }

  void searchRequest(String query) {
    final list = requestList.toList();
    list.sort((a, b) => a.requestNumber!.compareTo(b.requestNumber!));

    final searchResultList = <UserRequest>[];

    // ignore: avoid_function_literals_in_foreach_calls
    list.forEach((request) {
      if (request.userRequest!.toLowerCase().contains(query.toLowerCase()) ||
          request.address!.toLowerCase().contains(query.toLowerCase()) ||
          request.requestNumber.toString().contains(query.toLowerCase())) {
        searchResultList.add(request);
      }
    });

    emit(SearchchingRequest(
      searchResultList.reversed.toList(),
    ));
  }
}
