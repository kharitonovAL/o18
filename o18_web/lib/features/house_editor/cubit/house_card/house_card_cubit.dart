import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_web/utils/utils.dart';

part 'house_card_state.dart';

class HouseCardCubit extends Cubit<HouseCardState> {
  final House house;

  HouseCardCubit({
    required this.house,
  }) : super(HouseCardInitial());

  Future<void> saveChanges({
    required House house,
    required String? city,
    required String? street,
    required String? houseNumber,
    required int? year,
    required int? flatAmount,
    required int? floorAmount,
    required int? entranceAmount,
    required int? powerSwitchEntrance,
    required int? basementEntrance,
    required String? houseType,
    required String? roofType,
    required String? roofMaterialType,
    required String? powerSupply,
    required String? gasSupply,
    required String? heatSupply,
    required bool? hasBasement,
    required bool? hasFireFightingSupply,
  }) async {
    house
      ..city = city
      ..street = street
      ..houseNumber = houseNumber
      ..yearOfConstruction = year
      ..flatsCount = flatAmount
      ..floorsCount = floorAmount
      ..entranceCount = entranceAmount
      ..entranceWithPowerSwitch = powerSwitchEntrance
      ..entranceToBasement = basementEntrance
      ..houseType = houseType
      ..roofType = roofType
      ..roofMaterial = roofMaterialType
      ..powerSupply = powerSupply
      ..gasSupply = gasSupply
      ..heatSupply = heatSupply
      ..hasBasement = hasBasement
      ..hasFireFightingSupply = hasFireFightingSupply;

    final response = await house.update();
    response.success
        ? emit(HouseOperationSuccess())
        : emit(const HouseOperationFailed(
            error: ErrorText.houseUpdateFailure,
          ));
  }

  Future<void> deleteHouse({
    required House house,
  }) async {
    final response = await house.delete();
    response.success
        ? emit(HouseOperationSuccess())
        : emit(const HouseOperationFailed(
            error: ErrorText.houseDeleteFailure,
          ));
  }
}
