import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(
          authenticationRepository.currentUser.isNotEmpty
              ? AppState.authenticated(authenticationRepository.currentUser)
              : const AppState.unauthenticated(),
        ) {
    on<AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    _authenticationStatusSubscription =
        _authenticationRepository.user.listen((status) {
      add(
        AppUserChanged(status),
      );
    });
  }

  final AuthenticationRepository _authenticationRepository;

  late final StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  void _onUserChanged(
    AppUserChanged event,
    Emitter<AppState> emit,
  ) {
    if (event.status == AuthenticationStatus.authenticated) {
      final user = _authenticationRepository.currentUser;
      if (user.isEmpty) {
        _authenticationRepository.logout();
      } else {
        emit(AppState.authenticated(user));
      }
    } else {
      emit(const AppState.unauthenticated());
    }
  }

  void _onLogoutRequested(
    AppLogoutRequested event,
    Emitter<AppState> emit,
  ) {
    unawaited(
      _authenticationRepository.logout(),
    );
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    return super.close();
  }
}
