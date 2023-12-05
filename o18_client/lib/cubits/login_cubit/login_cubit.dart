import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository authRepository;

  LoginCubit({
    required this.authRepository,
  }) : super(LoginInitial());

  Future<void> loginButtonPressed({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      final user = await authRepository.login(
        email: email,
        password: password,
      );

      if (user != null) {
        emit(LoginSuccess());
      } else {
        emit(
          LoginFailure(error: 'Неверный адрес электронной почты или пароль!'),
        );
      }
    } catch (error) {
      emit(LoginFailure(error: error.toString()));
    }
  }
}
