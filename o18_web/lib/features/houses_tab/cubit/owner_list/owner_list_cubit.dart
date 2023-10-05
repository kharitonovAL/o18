import 'package:bloc/bloc.dart';
import 'package:database_repository/database_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:model_repository/model_repository.dart';

part 'owner_list_state.dart';

class OwnerListCubit extends Cubit<OwnerListState> {
  OwnerListCubit() : super(OwnerListInitial());

  String? accNumber;
  final _ownerRepository = OwnerRepository();

  Future<void> loadOwnerList({
    required String accountNumber,
  }) async {
    emit(OwnerListLoading());

    final list = await _ownerRepository.loadOwnerListForAccount(
      accountNumber: accountNumber,
    );

    emit(OwnerListLoaded(list));
  }

  void clearOwner() => emit(OwnerListInitial());

  Future<bool> saveChanges({
    required Owner owner,
    required String name,
    required int phoneNumber,
    required String email,
    required double square,
  }) async {
    owner
      ..name = name
      ..phoneNumber = phoneNumber
      ..email = email
      ..squareMeters = square;

    final result = await owner.update();

    return result.success;
  }
}
