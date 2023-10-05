import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:database_repository/database_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_web/utils/utils.dart';

part 'staff_state.dart';

class StaffCubit extends Cubit<StaffState> {
  final Partner partner;

  StaffCubit({
    required this.partner,
  }) : super(StaffInitial()) {
    loadStaff();
  }

  final _staffRepository = StaffRepository();
  final _authRepository = AuthenticationRepository();

  Future<void> loadStaff() async {
    emit(StaffLoading());

    final list = await _staffRepository.getStaffList()
      ..retainWhere(
        (s) => s.partnerId == partner.objectId,
      );

    emit(StaffLoaded(list));
  }

  Future<void> addStaff({
    required String name,
    required String phoneNumber,
    required String position,
    required String email,
    required String role,
  }) async {
    final staff = Staff();
    staff
      ..partnerId = partner.objectId
      ..name = name
      ..email = email
      ..position = position
      ..phoneNumber = phoneNumber.cleanNumber
      ..role = role;

    final result = await staff.save();

    result.success
        ? emit(StaffAdded())
        : emit(const StaffAddFailed(
            ErrorText.staffAddFailure,
          ));
  }

  Future<void> updateStaff({
    required Staff staff,
    required String name,
    required String phoneNumber,
    required String email,
    required String position,
    required String role,
    required bool isRegistered,
  }) async {
    staff
      ..partnerId = partner.objectId
      ..name = name
      ..phoneNumber = phoneNumber.cleanNumber
      ..email = email
      ..position = position
      ..role = role
      ..isRegistered = isRegistered;

    final result = await staff.update();

    result.success
        ? emit(StaffAdded())
        : emit(const StaffAddFailed(
            ErrorText.staffUpdateFailure,
          ));
  }

  Future<void> deleteStaff({
    required Staff staff,
  }) async {
    final result = await staff.delete();
    result.success
        ? emit(StaffDeleted())
        : emit(const StaffDeleteFailed(
            ErrorText.staffDeleteFailure,
          ));
  }

  Future<void> registerStaff({
    required Staff staff,
  }) async {
    await _authRepository.signUpStaff(
      email: staff.email!,
      password: '111111',
    );

    staff.isRegistered = true;
    await staff.update();
    await loadStaff();
  }

  Future<void> deleteStaffRegistration({
    required Staff staff,
  }) async {
    await _authRepository.deleteUser(
      email: staff.email!,
    );
    staff.isRegistered = false;
    await staff.update();
    await loadStaff();
  }
}
