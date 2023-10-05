import 'package:bloc/bloc.dart';
import 'package:database_repository/database_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_web/utils/constants.dart';

part 'owner_dropdown_state.dart';

class OwnerDropdownCubit extends Cubit<OwnerDropdownState> {
  final RequestSelection requestSelection;
  final UserRequest? userRequest;

  OwnerDropdownCubit({
    this.requestSelection = RequestSelection.existedRequest,
    this.userRequest,
  }) : super(OwnerDropdownInitial()) {
    if (requestSelection == RequestSelection.existedRequest) {
      loadOwnerData(accountNumber: userRequest!.accountNumber!);
    }
  }

  final _ownerRepository = OwnerRepository();

  Future<void> loadOwnerData({
    required String accountNumber,
  }) async {
    emit(OwnerDataLoading());
    final ownerList = await _ownerRepository.loadOwnerListForAccount(
      accountNumber: accountNumber,
    );

    ownerList.isEmpty
        ? emit(OwnerDataError())
        : emit(OwnerDataLoaded(ownerList));
  }

  Future<void> updateOwnerName({
    required Owner owner,
    required String name,
    required String accountNumber,
  }) async {
    emit(OwnerDataLoading());
    owner.name = name;
    final response = await owner.update();

    if (response.success) {
      final ownerList = await _ownerRepository.loadOwnerListForAccount(
        accountNumber: accountNumber,
      );

      ownerList.isEmpty
          ? emit(OwnerDataError())
          : emit(OwnerDataLoaded(ownerList));
    } else {
      emit(OwnerDataError());
    }
  }

  Future<void> clear() async => emit(
        OwnerDropdownInitial(),
      );
}
