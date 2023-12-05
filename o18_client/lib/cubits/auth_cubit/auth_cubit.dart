import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthenticationState> {
  final AuthRepository authRepo;

  AuthCubit({
    required this.authRepo,
  }) : super(AuthenticationUninitialized());

  Future<void> appStarted() async {
    final user = await authRepo.currentUser();
    if (user != null) {
      emit(AuthenticationAuthenticated());
    } else {
      emit(AuthenticationUnauthenticated());
    }
  }
}
