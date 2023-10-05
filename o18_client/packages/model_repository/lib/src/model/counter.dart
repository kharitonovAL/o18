import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class Counter extends ParseObject implements ParseCloneable {
  static const String _keyTableName = 'Counter';

  @override
  Counter clone(Map<String, dynamic> map) => Counter.clone()..fromJson(map);

  Counter() : super(_keyTableName);
  Counter.clone() : this();

  static const String keyObjectId = 'objectId';
  static const String keyFlatId = 'flatId';
  static const String keyServiceTitle = 'serviceTitle';
  static const String keySerialNumber = 'serialNumber';
  static const String keyReadingDateList = 'readingDateList';
  static const String keyDayReadingList = 'dayReadingList';
  static const String keyNightReadingList = 'nightReadingList';
  static const String keyCurrentReadingDate = 'currentReadingDate';
  static const String keyCurrentDayReading = 'currentDayReading';
  static const String keyCurrentNightReading = 'currentNightReading';
  static const String keyCounterTitle = 'counterTitle';
  static const String keyAddress = 'address';

  @override
  String? get objectId => get<String>(keyObjectId);

  String? get flatId => get<String>(keyFlatId);
  set flatId(String? flatId) => set<String>(
        keyFlatId,
        flatId ?? 'defaultValue',
      );

  String? get serviceTitle => get<String>(keyServiceTitle);
  set serviceTitle(String? serviceTitle) => set<String>(
        keyServiceTitle,
        serviceTitle ?? 'defaultValue',
      );

  String? get serialNumber => get<String>(keySerialNumber);
  set serialNumber(String? serialNumber) => set<String>(
        keySerialNumber,
        serialNumber ?? 'defaultValue',
      );

  /// Elements of `DateTime` type
  List? get readingDateList => get<List>(keyReadingDateList);
  set readingDateList(List? readingDateList) => set<List>(
        keyReadingDateList,
        readingDateList ?? <dynamic>[],
      );

  /// Elements of `int` type
  List? get dayReadingList => get<List>(keyDayReadingList);
  set dayReadingList(List? dayReadingList) => set<List>(
        keyDayReadingList,
        dayReadingList ?? <dynamic>[],
      );

  /// Elements of `int` type
  List? get nightReadingList => get<List>(keyNightReadingList);
  set nightReadingList(List? nightReadingList) => set<List>(
        keyNightReadingList,
        nightReadingList ?? <dynamic>[],
      );

  DateTime? get currentReadingDate => get<DateTime>(keyCurrentReadingDate);
  set currentReadingDate(DateTime? currentReadingDate) => set<DateTime>(
        keyCurrentReadingDate,
        currentReadingDate ?? DateTime.now().toLocal(),
      );

  double get currentDayReading {
    final value = get<double>(keyCurrentDayReading);
    return double.parse('$value');
  }

  set currentDayReading(double currentDayReading) => set<double>(
        keyCurrentDayReading,
        currentDayReading,
      );

  double get currentNightReading {
    final value = get<double>(keyCurrentNightReading);
    return double.parse('$value');
  }

  set currentNightReading(double currentNightReading) => set<double>(
        keyCurrentNightReading,
        currentNightReading,
      );

  String? get counterTitle => get<String>(keyCounterTitle);
  set counterTitle(String? counterTitle) => set<String>(
        keyCounterTitle,
        counterTitle ?? 'defaultValue',
      );

  String? get address => get<String>(keyAddress);
  set address(String? address) => set<String>(
        keyAddress,
        address ?? 'defaultValue',
      );
}
