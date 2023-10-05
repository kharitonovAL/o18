import 'package:authentication_repository/authentication_repository.dart';
import 'package:authentication_repository/exception/authentication_exception.dart';
import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:o18_web/features/login/login.dart';
import 'package:o18_web/features/login/models/models.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(
    this._authenticationRepository,
  ) : super(LoginState());

  final AuthenticationRepository _authenticationRepository;

  void emailChanged(
    String value,
  ) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      password: state.password,
    ));
  }

  void passwordChanged(
    String value,
  ) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      email: state.email,
    ));
  }

  Future<void> login({
    required String userRole,
  }) async {
    if (state.isNotValid) {
      return;
    }

    emit(state.copyWith(
      status: FormzSubmissionStatus.inProgress,
    ));

    try {
      await _authenticationRepository.login(
        email: state.email.value,
        password: state.password.value,
        userRole: userRole,
      );
      emit(state.copyWith(
        status: FormzSubmissionStatus.success,
      ));
    } on AuthenticationException catch (e) {
      emit(state.copyWith(
        errorCode: e.code,
        status: FormzSubmissionStatus.failure,
      ));
    } catch (_) {
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
      ));
    }
  }
}
