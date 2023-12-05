import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class UserRequest extends ParseObject implements ParseCloneable {
  static const String _keyTableName = 'UserRequest';

  UserRequest() : super(_keyTableName);
  UserRequest.clone() : this();

  @override
  UserRequest clone(
    Map<String, dynamic> map,
  ) =>
      UserRequest.clone()..fromJson(map);

  static const String keyAccountNumber = 'accountNumber';
  static const String keyUserRequest = 'userRequest';
  static const String keyRequestNote = 'requestNote';
  static const String keyRequestNumber = 'requestNumber';
  static const String keyJobType = 'jobType';
  static const String keyRequestDate = 'requestDate';
  static const String keyResponse = 'response';
  static const String keyResponseDate = 'responseDate';
  static const String keyStatus = 'status';
  static const String keyAddress = 'address';
  static const String keyFlatNumber = 'flatNumber';
  static const String keyUserName = 'userName';
  static const String keyPhoneNumber = 'phoneNumber';
  static const String keyOwnerId = 'ownerId';
  static const String keyAuthor = 'author';
  static const String keyPartnerId = 'partnerId';
  static const String keyMasterId = 'masterId';
  static const String keyStaffId = 'staffId';
  static const String keyCancelReason = 'cancelReason';
  static const String keyUserUid = 'userUid';
  static const String keyUserToken = 'userToken';
  static const String keyDebt = 'debt';
  static const String keyWasSeen = 'wasSeen';
  static const String keyWasSeenByStaff = 'wasSeenByStaff';
  static const String keyDateSeenByStaff = 'dateSeenByStaff';
  static const String keyRequestHistory = 'requestHistory';
  static const String keyRequestType = 'requestType';

  /// Number of user account in Management Company system.
  String? get accountNumber => get<String>(keyAccountNumber);
  set accountNumber(String? accountNumber) => set<String>(
        keyAccountNumber,
        accountNumber ?? '',
      );

  /// The user's request, it's text.
  String? get userRequest => get<String>(keyUserRequest);
  set userRequest(String? userRequest) => set<String>(
        keyUserRequest,
        userRequest ?? '',
      );

  /// Additional notes for request. This notes can add only operator,
  /// and only staff can see this notes.
  String? get requestNote => get<String>(keyRequestNote);
  set requestNote(String? requestNote) => set<String>(
        keyRequestNote,
        requestNote ?? '',
      );

  /// The request's serial number.
  int? get requestNumber => get<int>(keyRequestNumber);
  set requestNumber(int? requestNumber) => set<int>(
        keyRequestNumber,
        requestNumber ?? 0,
      );

  /// Define job type or category.
  String? get jobType => get<String>(keyJobType) ?? 'Не выбран';
  set jobType(String? jobType) => set<String>(
        keyJobType,
        jobType ?? '',
      );

  /// Define job type or category.
  String? get requestType => get<String>(keyRequestType) ?? 'Не выбран';
  set requestType(String? requestType) => set<String>(
        keyRequestType,
        requestType ?? '',
      );

  /// The date the request was created on.
  DateTime? get requestDate => get<DateTime>(keyRequestDate);
  set requestDate(DateTime? requestDate) => set<DateTime>(
        keyRequestDate,
        requestDate ?? DateTime.now(),
      );

  /// The response text that will be displayed to the client after
  /// operator click on Close Request button.
  String? get response => get<String>(keyResponse);
  set response(String? response) => set<String>(
        keyResponse,
        response ?? '',
      );

  /// The date when the request has to be done.
  DateTime? get responseDate => get<DateTime>(keyResponseDate);
  set responseDate(DateTime? responseDate) => set<DateTime>(
        keyResponseDate,
        responseDate ?? DateTime.now(),
      );

  /// The current request status (received, in progress, etc.).
  String? get status => get<String>(keyStatus);
  set status(String? status) => set<String>(
        keyStatus,
        status ?? '',
      );

  String? get address => get<String>(keyAddress);
  set address(String? address) => set<String>(
        keyAddress,
        address ?? '',
      );

  String? get flatNumber => get<String>(keyFlatNumber);
  set flatNumber(String? flatNumber) => set<String>(
        keyFlatNumber,
        flatNumber ?? '',
      );

  String? get userName => get<String>(keyUserName);
  set userName(String? userName) => set<String>(
        keyUserName,
        userName ?? '',
      );

  String? get phoneNumber => get<String>(keyPhoneNumber);
  set phoneNumber(String? phoneNumber) => set<String>(
        keyPhoneNumber,
        phoneNumber ?? '',
      );

  String? get ownerId => get<String>(keyOwnerId);
  set ownerId(String? ownerId) => set<String>(
        keyOwnerId,
        ownerId ?? '',
      );

  String? get author => get<String>(keyAuthor);
  set author(String? author) => set<String>(
        keyAuthor,
        author ?? '',
      );

  String? get partnerId => get<String>(keyPartnerId);
  set partnerId(String? partnerId) => set<String>(
        keyPartnerId,
        partnerId ?? '',
      );

  String? get masterId => get<String>(keyMasterId);
  set masterId(String? masterId) => set<String>(
        keyMasterId,
        masterId ?? '',
      );

  String? get staffId => get<String>(keyStaffId);
  set staffId(String? staffId) => set<String>(
        keyStaffId,
        staffId ?? '',
      );

  String? get cancelReason => get<String>(keyCancelReason);
  set cancelReason(String? cancelReason) => set<String>(
        keyCancelReason,
        cancelReason ?? '',
      );

  String? get userUid => get<String>(keyUserUid);
  set userUid(String? userUid) => set<String>(
        keyUserUid,
        userUid ?? '',
      );

  String? get userToken => get<String>(keyUserToken);
  set userToken(String? userToken) => set<String>(
        keyUserToken,
        userToken ?? '',
      );

  double get debt {
    final value = get<double>(keyDebt);
    return double.parse('$value');
  }

  set debt(double debt) => set<double>(keyDebt, debt);

  bool? get wasSeen => get<bool>(keyWasSeen);
  set wasSeen(bool? wasSeen) => set<bool>(
        keyWasSeen,
        wasSeen ?? false,
      );

  bool? get wasSeenByStaff => get<bool>(keyWasSeenByStaff);
  set wasSeenByStaff(bool? wasSeenByStaff) => set<bool>(
        keyWasSeenByStaff,
        wasSeenByStaff ?? false,
      );

  DateTime? get dateSeenByStaff => get<DateTime>(keyDateSeenByStaff);
  set dateSeenByStaff(DateTime? dateSeenByStaff) => set<DateTime>(
        keyDateSeenByStaff,
        dateSeenByStaff ?? DateTime.now(),
      );

  List? get requestHistory => get<List>(keyRequestHistory);
  set requestHistory(List? requestHistory) => set<List>(
        keyRequestHistory,
        requestHistory ?? <dynamic>[],
      );
}

/// Class represents user request's statuses. It's full name was `RequestStatus`,
/// but for convenience it was renamed to `RS`.
class RS {
  /// Получена
  static const received = 'Получена';

  /// Передана главному инженеру
  static const passedToTheChiefEngineer = 'Передана главному инженеру';

  /// Передана мастеру
  static const passedToTheMaster = 'Передана мастеру';

  /// В работе
  static const inProgress = 'В работе';

  /// Закрыта
  static const closed = 'Закрыта';

  /// Отозвана заявителем
  static const canceled = 'Отозвана заявителем';
}
