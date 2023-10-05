import 'package:bloc/bloc.dart';
import 'package:database_repository/database_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_web/utils/utils.dart';

part 'master_dropdown_state.dart';

class MasterDropdownCubit extends Cubit<MasterDropdownState> {
  final RequestSelection requestSelection;
  final UserRequest? userRequest;

  MasterDropdownCubit({
    this.requestSelection = RequestSelection.existedRequest,
    this.userRequest,
  }) : super(MasterDropdownInitial()) {
    if (requestSelection == RequestSelection.existedRequest) {
      if (userRequest!.partnerId != null) {
        loadMasterData(partnerId: userRequest!.partnerId!);
      }
    }
  }

  final _staffRepository = StaffRepository();

  Future<void> loadMasterData({
    required String partnerId,
  }) async {
    emit(MasterDataLoading());
    final masterList = await _staffRepository.getStaffList()
      ..retainWhere(
        (s) => s.role == StaffRole.master && s.partnerId == partnerId,
      );

    emit(MasterDataLoaded(masterList));
  }
}
