import 'package:parse_server_sdk/parse_server_sdk.dart';

class House extends ParseObject implements ParseCloneable {
  static const String _keyTableName = 'House';

  House() : super(_keyTableName);
  House.clone() : this();

  @override
  House clone(Map<String, dynamic> map) => House.clone()..fromJson(map);

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
        city ?? 'defaultValue',
      );

  String? get houseNumber => get<String>(keyHouseNumber);
  set houseNumber(String? houseNumber) => set<String>(
        keyHouseNumber,
        houseNumber ?? 'defaultValue',
      );

  String? get street => get<String>(keyStreet);
  set street(String? street) => set<String>(
        keyStreet,
        street ?? 'defaultValue',
      );

  String? get houseType => get<String>(keyHouseType);
  set houseType(String? houseType) => set<String>(
        keyHouseType,
        houseType ?? HouseType.brick,
      );

  String? get roofType => get<String>(keyRoofType);
  set roofType(String? roofType) => set<String>(
        keyRoofType,
        roofType ?? RoofType.flat,
      );

  String? get roofMaterial => get<String>(keyRoofMaterial);
  set roofMaterial(String? roofMaterial) => set<String>(
        keyRoofMaterial,
        roofMaterial ?? RoofMaterial.metalProfile,
      );

  int? get flatsCount => get<int>(keyFlatsCount);
  set flatsCount(int? flatsCount) => set<int>(
        keyFlatsCount,
        flatsCount ?? 1,
      );

  int? get floorsCount => get<int>(keyFloorsCount);
  set floorsCount(int? floorsCount) => set<int>(
        keyFloorsCount,
        floorsCount ?? 1,
      );

  int? get entranceCount => get<int>(keyEntranceCount);
  set entranceCount(int? entranceCount) => set<int>(
        keyEntranceCount,
        entranceCount ?? 1,
      );

  int? get entranceWithPowerSwitch => get<int>(keyEntranceWithPowerSwitch);
  set entranceWithPowerSwitch(int? entranceWithPowerSwitch) => set<int>(
        keyEntranceWithPowerSwitch,
        entranceWithPowerSwitch ?? 1,
      );

  int? get entranceToBasement => get<int>(keyEntranceToBasement);
  set entranceToBasement(int? entranceToBasement) => set<int>(
        keyEntranceToBasement,
        entranceToBasement ?? 1,
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
}

class HousePurpose {
  static const living = 'Жилое';
  static const industrial = 'Промышленное';
  static const maintenance = 'Ремонтно-эксплуатационное';
  static const administrative = 'Административное';

  static final list = [living, industrial, maintenance, administrative];
}

class HeatSupply {
  static const centralized = 'Централизованное';
  static const localDecentralized = 'Местное децентрализованное';
  static const individualDecentralized = 'Индивидуальное децентрализованное';

  static final list = [
    centralized,
    localDecentralized,
    individualDecentralized
  ];
}

class GasSupply {
  static const centralized = 'Централизованное';
  static const gasCylinder = 'Газобалонное';

  static final list = [centralized, gasCylinder];
}

class PowerSupply {
  static const centralized = 'Централизованное';

  static final list = [centralized];
}

class FuelType {
  static const gas = 'Газ';
  static const solidFuel = 'Твердое топливо';
  static const liquidFuel = 'Жидкое топливо';

  static final list = [gas, solidFuel, liquidFuel];
}

class HouseType {
  static const panel = 'Панельный';
  static const brick = 'Кирпичный';
  static const monolithic = 'Монолитный';
  static const wooden = 'Деревянный';

  static final list = [panel, brick, monolithic, wooden];
}

class RoofType {
  static const flat = 'Плоская';
  static const pitched = 'Скатная';

  static final list = [flat, pitched];
}

class RoofMaterial {
  static const slate = 'Шифер';
  static const metalProfile = 'Металлопрофиль';
  static const metalTile = 'Металлочерепица';
  static const reinforcedConcrete = 'Железобетонная';
  static const surfacing = 'Наплавляемое покрытие';

  static final list = [
    slate,
    metalProfile,
    metalTile,
    reinforcedConcrete,
    surfacing
  ];

//  static final flatRoofList = [reinforcedConcrete, surfacing];
//  static final pitchedRoofList = [slate, metalProfile, metalTile];
}

class Basement {
  static const exist = 'Есть';
  static const notExist = 'Отсутствует';

  static final list = [exist, notExist];
}

class FireFightingSupply {
  static const exist = 'Есть';
  static const notExist = 'Отсутствует';

  static final list = [exist, notExist];
}
