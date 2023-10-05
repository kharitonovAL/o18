import 'package:bloc/bloc.dart';
import 'package:database_repository/database_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_web/utils/utils.dart';

part 'house_council_state.dart';

class HouseCouncilCubit extends Cubit<HouseCouncilState> {
  final House house;

  HouseCouncilCubit({
    required this.house,
  }) : super(HouseCouncilInitial()) {
    loadHouseCouncil();
  }

  final _councilRepository = CouncilRepository();

  Future<void> loadHouseCouncil() async {
    emit(HouseCouncilLoading());

    final list = await _councilRepository.getCouncilMemberList(
      houseId: house.objectId!,
    );

    emit(HouseCouncilLoaded(list));
  }

  Future<void> addCouncilMember({
    required String name,
    required String phoneNumber,
    required String flatNumber,
    required bool isHouseKeeper,
  }) async {
    final member = CouncilMember();
    member
      ..houseId = house.objectId
      ..flatNumber = flatNumber
      ..isHousekeeper = isHouseKeeper
      ..name = name
      ..phoneNumber = phoneNumber;

    final result = await member.save();

    result.success
        ? emit(HouseCouncilAdded())
        : emit(const HouseCouncilAddFailed(
            ErrorText.houseCouncilMemberAddFailure,
          ));
  }

  Future<void> updateMember({
    required CouncilMember member,
    required String name,
    required String phoneNumber,
    required String flatNumber,
    required bool isHouseKeeper,
  }) async {
    member
      ..houseId = house.objectId
      ..flatNumber = flatNumber
      ..isHousekeeper = isHouseKeeper
      ..name = name
      ..phoneNumber = phoneNumber;

    final result = await member.update();

    result.success
        ? emit(HouseCouncilAdded())
        : emit(const HouseCouncilAddFailed(
            ErrorText.houseCouncilMemberUpdateFailure,
          ));
  }

  Future<void> deleteMember({
    required CouncilMember member,
  }) async {
    final result = await member.delete();
    result.success
        ? emit(HouseCouncilDeleted())
        : emit(const HouseCouncilDeleteFailed(
            ErrorText.houseCouncilMemberDeleteFailure,
          ));
  }

  Future<void> saveChanges({
    required CouncilMember member,
    required String name,
    required String flatNumber,
    required String phoneNumber,
    required bool isHouseKeeper,
  }) async {
    member
      ..name = name
      ..flatNumber = flatNumber
      ..phoneNumber = phoneNumber
      ..isHousekeeper = isHouseKeeper;

    final result = await member.update();
    result.success
        ? emit(HouseCouncilUpdated())
        : emit(const HouseCouncilUpdateFailed(
            ErrorText.houseCouncilMemberUpdateFailure,
          ));
  }
}
