import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository authRepository;

  SignUpCubit({
    required this.authRepository,
  }) : super(SignUpInitial());

  Future<void> signupButtonPressed({
    required String email,
    required String password,
  }) async {
    emit(SignUpLoading());
    try {
      final user = await authRepository.signUp(
        email: email,
        password: password,
      );

      if (user != null) {
        emit(SignUpSuccess());
      } else {
        emit(const SignUpFailure(error: 'Signup Failed'));
      }
    } catch (error) {
      emit(SignUpFailure(error: error.toString()));
    }
  }
}
