import 'package:parse_server_sdk/parse_server_sdk.dart';

class UserRequest extends ParseObject implements ParseCloneable {
  static const String _keyTableName = 'UserRequest';

  UserRequest() : super(_keyTableName);
  UserRequest.clone() : this();

  @override
  UserRequest clone(Map<String, dynamic> map) =>
      UserRequest.clone()..fromJson(map);

  static const String keyAccountNumber = 'accountNumber';
  static const String keyUserRequest = 'userRequest';
  static const String keyRequestNote = 'requestNote';
  static const String keyRequestNumber = 'requestNumber';
  static const String keyIsFailure = 'isFailure';
  static const String keyIsPaid = 'isPaid';
  static const String keyIsMaintenance = 'isMaintenance';
  static const String keyJobType = 'jobType';
  static const String keyRequestDate = 'requestDate';
  static const String keyResponse = 'response';
  static const String keyResponseDate = 'responseDate';
  static const String keyStatus = 'status';
  static const String keyAddress = 'address';
  static const String keyFlatNumber = 'flatNumber';
  static const String keyUserName = 'userName';
  static const String keyPhoneNumber = 'phoneNumber';
  static const String keyAuthor = 'author';
  static const String keyPartnerTitle = 'partnerTitle';
  static const String keyMasterStaff = 'masterStaff';
  static const String keyPartnerStaff = 'partnerStaff';
  static const String keyCancelReason = 'cancelReason';
  static const String keyUserUid = 'userUid';
  static const String keyUserToken = 'userToken';
  static const String keyDebt = 'debt';
  static const String keyWasSeen = 'wasSeen';
  static const String keyOwnerId = 'ownerId';

  String? get accountNumber => get<String>(keyAccountNumber);
  set accountNumber(String? accountNumber) => set<String>(
        keyAccountNumber,
        accountNumber ?? 'defaultValue',
      );

  String? get userRequest => get<String>(keyUserRequest);
  set userRequest(String? userRequest) => set<String>(
        keyUserRequest,
        userRequest ?? 'defaultValue',
      );

  String? get requestNote => get<String>(keyRequestNote);
  set requestNote(String? requestNote) => set<String>(
        keyRequestNote,
        requestNote ?? 'defaultValue',
      );

  int? get requestNumber => get<int>(keyRequestNumber);
  set requestNumber(int? requestNumber) => set<int>(
        keyRequestNumber,
        requestNumber ?? 0,
      );

  bool? get isFailure => get<bool>(keyIsFailure);
  set isFailure(bool? isFailure) => set<bool>(
        keyIsFailure,
        isFailure ?? false,
      );

  bool? get isPaid => get<bool>(keyIsPaid);
  set isPaid(bool? isPaid) => set<bool>(
        keyIsPaid,
        isPaid ?? false,
      );

  bool? get isMaintenance => get<bool>(keyIsMaintenance);
  set isMaintenance(bool? isMaintenance) => set<bool>(
        keyIsMaintenance,
        isMaintenance ?? false,
      );

  String? get jobType => get<String>(keyJobType);
  set jobType(String? jobType) => set<String>(
        keyJobType,
        jobType ?? 'defaultValue',
      );

  DateTime? get requestDate => get<DateTime>(keyRequestDate);
  set requestDate(DateTime? requestDate) => set<DateTime>(
        keyRequestDate,
        requestDate ?? DateTime.now().toLocal(),
      );

  String? get response => get<String>(keyResponse);
  set response(String? response) => set<String>(
        keyResponse,
        response ?? 'defaultValue',
      );

  DateTime? get responseDate => get<DateTime>(keyResponseDate);
  set responseDate(DateTime? responseDate) => set<DateTime>(
        keyResponseDate,
        responseDate ?? DateTime.now().toLocal(),
      );

  String? get status => get<String>(keyStatus);
  set status(String? status) => set<String>(
        keyStatus,
        status ?? RequestStatus.received,
      );

  String? get address => get<String>(keyAddress);
  set address(String? address) => set<String>(
        keyAddress,
        address ?? 'defaultValue',
      );

  String? get flatNumber => get<String>(keyFlatNumber);
  set flatNumber(String? flatNumber) => set<String>(
        keyFlatNumber,
        flatNumber ?? 'defaultValue',
      );

  String? get userName => get<String>(keyUserName);
  set userName(String? userName) => set<String>(
        keyUserName,
        userName ?? 'defaultValue',
      );

  int? get phoneNumber => get<int>(keyPhoneNumber);
  set phoneNumber(int? phoneNumber) => set<int>(
        keyPhoneNumber,
        phoneNumber ?? 89120000000,
      );

  String? get author => get<String>(keyAuthor);
  set author(String? author) => set<String>(
        keyAuthor,
        author ?? 'Оператор',
      );

  String? get partnerTitle => get<String>(keyPartnerTitle);
  set partnerTitle(String? partnerTitle) => set<String>(
        keyPartnerTitle,
        partnerTitle ?? 'defaultValue',
      );

  String? get masterStaff => get<String>(keyMasterStaff);
  set masterStaff(String? masterStaff) => set<String>(
        keyMasterStaff,
        masterStaff ?? 'defaultValue',
      );

  String? get partnerStaff => get<String>(keyPartnerStaff);
  set partnerStaff(String? partnerStaff) => set<String>(
        keyPartnerStaff,
        partnerStaff ?? 'defaultValue',
      );

  String? get cancelReason => get<String>(keyCancelReason);
  set cancelReason(String? cancelReason) => set<String>(
        keyCancelReason,
        cancelReason ?? 'defaultValue',
      );

  String? get userUid => get<String>(keyUserUid);
  set userUid(String? userUid) => set<String>(
        keyUserUid,
        userUid ?? 'defaultValue',
      );

  String? get userToken => get<String>(keyUserToken);
  set userToken(String? userToken) => set<String>(
        keyUserToken,
        userToken ?? 'defaultValue',
      );

  double? get debt => get<double>(keyDebt);
  set debt(double? debt) => set<double>(
        keyDebt,
        debt ?? 0,
      );

  bool? get wasSeen => get<bool>(keyWasSeen);
  set wasSeen(bool? wasSeen) => set<bool>(
        keyWasSeen,
        wasSeen ?? false,
      );

  String? get ownerId => get<String>(keyOwnerId);
  set ownerId(String? ownerId) => set<String>(
        keyOwnerId,
        ownerId ?? 'defaultValue',
      );
}

class RequestStatus {
  static const received = 'Получена';
  static const passedToTheChiefEngineer = 'Передана главному инженеру';
  static const passedToTheMaster = 'Передана мастеру';
  static const inProgress = 'В работе';
  static const completed = 'Выполнена';
  static const closed = 'Закрыта';
  static const canceled = 'Отозвана заявителем';
}