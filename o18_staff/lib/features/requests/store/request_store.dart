import 'package:database_repository/database_repository.dart';
import 'package:mobx/mobx.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_staff/utils/strings/request_string.dart';
part 'request_store.g.dart';

class RequestStore = _RequestStore with _$RequestStore;

abstract class _RequestStore with Store {
  final _userRequestRepo = UserRequestRepository();

  /// this variable needed to store original list of user requests,
  /// because when fires sorting or searching method,
  /// it will affect the list itself, and the data will be lost.
  /// so here we safely store it.
  List<UserRequest> _userRequestList = [];

  @observable
  List<UserRequest> userRequestList = [];

  @observable
  String currentSorting = RequestTabString.sortNewFirst;

  @action
  Future<void> loadUserRequestList({
    required Staff staff,
  }) async {
    _userRequestList = await _userRequestRepo.getUserRequestList();

    if (staff.role == StaffRole.staff) {
      _userRequestList.retainWhere(
        (r) => r.staffId == staff.objectId,
      );
    }

    if (staff.role == StaffRole.master) {
      _userRequestList.retainWhere(
        (r) => r.masterId == staff.objectId,
      );
    }

    _userRequestList.retainWhere(
      (r) => r.status != RS.closed && r.status != RS.canceled,
    );

    userRequestList = _userRequestList.toList();
    sortFromNewToOld();
  }

  @action
  void sortFromOldToNew() {
    final list = _userRequestList.toList();
    list.sort((a, b) => a.requestNumber!.compareTo(b.requestNumber!));
    userRequestList = list;
    currentSorting = RequestTabString.sortOldFirst;
  }

  @action
  void sortFromNewToOld() {
    final list = _userRequestList.toList();
    list.sort((a, b) => a.requestNumber!.compareTo(b.requestNumber!));
    userRequestList = list.reversed.toList();
    currentSorting = RequestTabString.sortNewFirst;
  }

  @action
  void sortFailureOnly() {
    final list = _userRequestList.toList();
    list.retainWhere((r) => r.requestType == RequestType.failure);
    list.sort((a, b) => a.requestNumber!.compareTo(b.requestNumber!));
    userRequestList = list;
    currentSorting = RequestTabString.sortFailureOnly;
  }

  @action
  void searchRequest({
    required String query,
  }) {
    final list = _userRequestList.toList();
    final searchResultList = <UserRequest>[];

    // ignore: avoid_function_literals_in_foreach_calls
    list.forEach((r) {
      if (r.userRequest!.toLowerCase().contains(query.toLowerCase()) ||
          r.address!.toLowerCase().contains(query.toLowerCase()) ||
          r.requestNumber.toString().contains(query.toLowerCase())) {
        searchResultList.add(r);
      }
    });

    userRequestList = searchResultList;
  }
}
