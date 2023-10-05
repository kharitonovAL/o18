import 'package:bloc/bloc.dart';
import 'package:database_repository/database_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_web/utils/constants.dart';

part 'staff_dropdown_state.dart';

class StaffDropdownCubit extends Cubit<StaffDropdownState> {
  final RequestSelection requestSelection;
  final UserRequest? userRequest;

  StaffDropdownCubit({
    this.requestSelection = RequestSelection.existedRequest,
    this.userRequest,
  }) : super(StaffDropdownInitial()) {
    if (requestSelection == RequestSelection.existedRequest) {
      if (userRequest!.partnerId != null) {
        loadStaffData(partnerId: userRequest!.partnerId!);
      }
    }
  }

  final _staffRepository = StaffRepository();

  Future<void> loadStaffData({
    required String partnerId,
  }) async {
    emit(StaffDataLoading());
    final staffList = await _staffRepository.getStaffList()
      ..retainWhere(
        (s) => s.role == StaffRole.staff && s.partnerId == partnerId,
      );
    emit(StaffDataLoaded(staffList));
  }
}
