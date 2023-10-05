// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class Partner extends ParseObject implements ParseCloneable {
  static const String _keyTableName = 'Partner';

  @override
  Partner clone(Map<String, dynamic> map) => Partner.clone()..fromJson(map);

  Partner() : super(_keyTableName);
  Partner.clone() : this();

  static const String keyTitle = 'title';
  static const String keyFieldOfActivity = 'fieldOfActivity';
  static const String keyManagerName = 'managerName';
  static const String keyManagerPosition = 'managerPosition';
  static const String keyPostIndex = 'postIndex';
  static const String keyCity = 'city';
  static const String keyStreet = 'street';
  static const String keyHouseNumber = 'houseNumber';
  static const String keyOfficeNumber = 'officeNumber';
  static const String keyPhoneNumber = 'phoneNumber';
  static const String keyEmail = 'email';
  static const String keyFax = 'fax';
  static const String keyBankTitle = 'bankTitle';
  static const String keyBankBic = 'bankBic';
  static const String keyBankAccount = 'bankAccount';
  static const String keyBankCorrespondingAccount = 'bankCorrespondingAccount';

  String? get title => get<String>(keyTitle);
  set title(String? title) => set<String>(
        keyTitle,
        title ?? 'title',
      );

  String? get fieldOfActivity => get<String>(keyFieldOfActivity);
  set fieldOfActivity(String? fieldOfActivity) => set<String>(
        keyFieldOfActivity,
        fieldOfActivity ?? 'fieldOfActivity',
      );

  String? get managerName => get<String>(keyManagerName);
  set managerName(String? managerName) => set<String>(
        keyManagerName,
        managerName ?? 'managerName',
      );

  String? get managerPosition => get<String>(keyManagerPosition);
  set managerPosition(String? managerPosition) => set<String>(
        keyManagerPosition,
        managerPosition ?? 'managerPosition',
      );

  int? get postIndex => get<int>(keyPostIndex);
  set postIndex(int? postIndex) => set<int>(
        keyPostIndex,
        postIndex ?? 0,
      );

  String? get city => get<String>(keyCity);
  set city(String? city) => set<String>(
        keyCity,
        city ?? 'city',
      );

  String? get street => get<String>(keyStreet);
  set street(String? street) => set<String>(
        keyStreet,
        street ?? 'street',
      );

  String? get houseNumber => get<String>(keyHouseNumber);
  set houseNumber(String? houseNumber) => set<String>(
        keyHouseNumber,
        houseNumber ?? 'houseNumber',
      );

  String? get officeNumber => get<String>(keyOfficeNumber);
  set officeNumber(String? officeNumber) => set<String>(
        keyOfficeNumber,
        officeNumber ?? 'officeNumber',
      );

  int? get phoneNumber => get<int>(keyPhoneNumber);
  set phoneNumber(int? phoneNumber) => set<int>(
        keyPhoneNumber,
        phoneNumber ?? 0,
      );

  String? get email => get<String>(keyEmail);
  set email(String? email) => set<String>(
        keyEmail,
        email ?? 'email',
      );

  int? get fax => get<int>(keyFax);
  set fax(int? fax) => set<int>(
        keyFax,
        fax ?? 0,
      );

  String? get bankTitle => get<String>(keyBankTitle);
  set bankTitle(String? bankTitle) => set<String>(
        keyBankTitle,
        bankTitle ?? 'bankTitle',
      );

  String? get bankBic => get<String>(keyBankBic);
  set bankBic(String? bankBic) => set<String>(
        keyBankBic,
        bankBic ?? '0',
      );

  String? get bankAccount => get<String>(keyBankAccount);
  set bankAccount(String? bankAccount) => set<String>(
        keyBankAccount,
        bankAccount ?? '0',
      );

  String? get bankCorrespondingAccount =>
      get<String>(keyBankCorrespondingAccount);
  set bankCorrespondingAccount(String? bankCorrespondingAccount) => set<String>(
        keyBankCorrespondingAccount,
        bankCorrespondingAccount ?? '0',
      );

  String get fullAddress => '$postIndex, $city, ул.$street, дом $houseNumber, офис $officeNumber';

  // This overrides needed to prevent DropdownButton from exception
  // on two same item
  @override
  int get hashCode => objectId.hashCode;

  @override
  bool operator ==(Object other) =>
      other is Partner && other.objectId == objectId;
}
