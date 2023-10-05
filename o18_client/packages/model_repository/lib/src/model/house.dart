import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class House extends ParseObject implements ParseCloneable {
  static const String _keyTableName = 'House';

  @override
  House clone(Map<String, dynamic> map) => House.clone()..fromJson(map);

  House() : super(_keyTableName);
  House.clone() : this();

  static const String keyObjectId = 'objectId';
  static const String keyYearOfConstruction = 'yearOfConstruction';
  static const String keyHasBasement = 'hasBasement';
  static const String keyHeatSupply = 'heatSupply';
  static const String keyGasSupply = 'gasSupply';
  static const String keyFuelSupply = 'fuelSupply';
  static const String keyPowerSupply = 'powerSupply';
  static const String keyHasFireFightingSupply = 'hasFireFightingSupply';
  static const String keyCity = 'city';
  static const String keyHouseNumber = 'houseNumber';
  static const String keyStreet = 'street';
  static const String keyHouseType = 'houseType';
  static const String keyRoofType = 'roofType';
  static const String keyRoofMaterial = 'roofMaterial';
  static const String keyFlatsCount = 'flatsCount';
  static const String keyFloorsCount = 'floorsCount';
  static const String keyEntranceCount = 'entranceCount';
  static const String keyEntranceWithPowerSwitch = 'entranceWithPowerSwitch';
  static const String keyEntranceToBasement = 'entranceToBasement';
  static const String keyUidList = 'uidList';
  static const String keyMessagesList = 'messagesList';
  static const String keyFlatIdList = 'flatIdList';
  static const String keyIsUnderControl = 'isUnderControl';

  @override
  String? get objectId => get<String>(keyObjectId);

  int? get yearOfConstruction => get<int>(keyYearOfConstruction);
  set yearOfConstruction(int? yearOfConstruction) => set<int>(
        keyYearOfConstruction,
        yearOfConstruction ?? 0,
      );

  bool? get hasBasement => get<bool>(keyHasBasement);
  set hasBasement(bool? hasBasement) => set<bool>(
        keyHasBasement,
        hasBasement ?? false,
      );

  String? get heatSupply => get<String>(keyHeatSupply);
  set heatSupply(String? heatSupply) => set<String>(
        keyHeatSupply,
        heatSupply ?? HeatSupply.centralized,
      );

  String? get gasSupply => get<String>(keyGasSupply);
  set gasSupply(String? gasSupply) => set<String>(
        keyGasSupply,
        gasSupply ?? GasSupply.centralized,
      );

  String? get fuelSupply => get<String>(keyFuelSupply);
  set fuelSupply(String? fuelSupply) => set<String>(
        keyFuelSupply,
        fuelSupply ?? FuelType.gas,
      );

  String? get powerSupply => get<String>(keyPowerSupply);
  set powerSupply(String? powerSupply) => set<String>(
        keyPowerSupply,
        powerSupply ?? PowerSupply.centralized,
      );

  bool? get hasFireFightingSupply => get<bool>(keyHasFireFightingSupply);
  set hasFireFightingSupply(bool? hasFireFightingSupply) => set<bool>(
        keyHasFireFightingSupply,
        hasFireFightingSupply ?? false,
      );

  String? get city => get<String>(keyCity);
  set city(String? city) => set<String>(
        keyCity,
        city ?? '',
      );

  String? get houseNumber => get<String>(keyHouseNumber);
  set houseNumber(String? houseNumber) => set<String>(
        keyHouseNumber,
        houseNumber ?? '',
      );

  String? get street => get<String>(keyStreet);
  set street(String? street) => set<String>(
        keyStreet,
        street ?? '',
      );

  String? get houseType => get<String>(keyHouseType);
  set houseType(String? houseType) => set<String>(
        keyHouseType,
        houseType ?? HouseType.monolithic,
      );

  String? get roofType => get<String>(keyRoofType);
  set roofType(String? roofType) => set<String>(
        keyRoofType,
        roofType ?? RoofType.flat,
      );

  String? get roofMaterial => get<String>(keyRoofMaterial);
  set roofMaterial(String? roofMaterial) => set<String>(
        keyRoofMaterial,
        roofMaterial ?? RoofMaterial.slate,
      );

  int? get flatsCount => get<int>(keyFlatsCount);
  set flatsCount(int? flatsCount) => set<int>(
        keyFlatsCount,
        flatsCount ?? 0,
      );

  int? get floorsCount => get<int>(keyFloorsCount);
  set floorsCount(int? floorsCount) => set<int>(
        keyFloorsCount,
        floorsCount ?? 0,
      );

  int? get entranceCount => get<int>(keyEntranceCount);
  set entranceCount(int? entranceCount) => set<int>(
        keyEntranceCount,
        entranceCount ?? 0,
      );

  int? get entranceWithPowerSwitch => get<int>(keyEntranceWithPowerSwitch);
  set entranceWithPowerSwitch(int? entranceWithPowerSwitch) => set<int>(
        keyEntranceWithPowerSwitch,
        entranceWithPowerSwitch ?? 0,
      );

  int? get entranceToBasement => get<int>(keyEntranceToBasement);
  set entranceToBasement(int? entranceToBasement) => set<int>(
        keyEntranceToBasement,
        entranceToBasement ?? 0,
      );

  /// need to leave `List` type because ParseServer objects doesn't support type safety
  List? get uidList => get<List>(keyUidList);
  set uidList(List? uidList) => set<List>(
        keyUidList,
        uidList ?? <dynamic>[],
      );

  /// need to leave `List` type because ParseServer objects doesn't support type safety
  List? get messagesList => get<List>(keyMessagesList);
  set messagesList(List? messagesList) => set<List>(
        keyMessagesList,
        messagesList ?? <dynamic>[],
      );

  /// need to leave `List` type because ParseServer objects doesn't support type safety
  List? get flatIdList => get<List>(keyFlatIdList);
  set flatIdList(List? flatIdList) => set<List>(
        keyFlatIdList,
        flatIdList ?? <dynamic>[],
      );

  bool? get isUnderControl => get<bool>(keyIsUnderControl);
  set isUnderControl(bool? isUnderControl) => set<bool>(
        keyIsUnderControl,
        isUnderControl ?? true,
      );

  String get addressToString => 'улица $street, $houseNumber';
}

class HousePurpose {
  /// Жилое
  static const living = 'Жилое';

  /// Промышленное
  static const industrial = 'Промышленное';

  /// Ремонтно-эксплуатационное
  static const maintenance = 'Ремонтно-эксплуатационное';
  
  /// Административное
  static const administrative = 'Административное';

  static final list = [living, industrial, maintenance, administrative];
}

class HeatSupply {
  /// Централизованное
  static const centralized = 'Централизованное';
  
  /// Местное децентрализованное
  static const localDecentralized = 'Местное децентрализованное';
  
  /// Индивидуальное децентрализованное
  static const individualDecentralized = 'Индивидуальное децентрализованное';

  static final list = [
    centralized,
    localDecentralized,
    individualDecentralized
  ];
}

class GasSupply {
  /// Централизованное
  static const centralized = 'Централизованное';
  
  /// Газобалонное
  static const gasCylinder = 'Газобалонное';

  static final list = [centralized, gasCylinder];
}

class PowerSupply {
  /// Централизованное
  static const centralized = 'Централизованное';

  static final list = [centralized];
}

class FuelType {
  /// Газ
  static const gas = 'Газ';

  /// Твердое топливо
  static const solidFuel = 'Твердое топливо';

  /// Жидкое топливо
  static const liquidFuel = 'Жидкое топливо';

  static final list = [gas, solidFuel, liquidFuel];
}

class HouseType {
  /// Панельный
  static const panel = 'Панельный';
  
  /// Кирпичный
  static const brick = 'Кирпичный';

  /// Монолитный
  static const monolithic = 'Монолитный';

  /// Деревянный
  static const wooden = 'Деревянный';

  static final list = [panel, brick, monolithic, wooden];
}

class RoofType {
  /// Плоская
  static const flat = 'Плоская';

  /// Скатная
  static const pitched = 'Скатная';

  static final list = [flat, pitched];
}

class RoofMaterial {
  /// Шифер
  static const slate = 'Шифер';

  /// Металлопрофиль
  static const metalProfile = 'Металлопрофиль';

  /// Металлочерепица
  static const metalTile = 'Металлочерепица';

  /// Железобетонная
  static const reinforcedConcrete = 'Железобетонная';

  /// Наплавляемое покрытие
  static const surfacing = 'Наплавляемое покрытие';

  static final list = [
    slate,
    metalProfile,
    metalTile,
    reinforcedConcrete,
    surfacing
  ];
}

class Basement {
  /// Есть
  static const exist = 'Есть';

  /// Отсутствует
  static const notExist = 'Отсутствует';

  static final list = [exist, notExist];
}

class FireFightingSupply {
  /// Есть
  static const exist = 'Есть';

  /// Отсутствует
  static const notExist = 'Отсутствует';

  static final list = [exist, notExist];
}
