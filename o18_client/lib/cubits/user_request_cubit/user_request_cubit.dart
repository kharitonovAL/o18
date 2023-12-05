import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:database_repository/database_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:model_repository/model_repository.dart';

part 'user_request_state.dart';

class UserRequestCubit extends Cubit<UserRequestState> {
  final AuthRepository authRepo;
  final UserRequestRepository userRequestRepository;
  final OwnerRepository ownerRepository;
  final AccountRepository accountRepository;

  UserRequestCubit({
    required this.authRepo,
    required this.userRequestRepository,
    required this.ownerRepository,
    required this.accountRepository,
  }) : super(UserRequestInitial()) {
    loadUserRequestList(
      accountRepository: accountRepository,
      authRepo: authRepo,
      ownerRepository: ownerRepository,
    );
  }

  Future<void> loadUserRequestList({
    required AccountRepository accountRepository,
    required AuthRepository authRepo,
    required OwnerRepository ownerRepository,
  }) async {
    emit(UserRequestLoading());
    final list = await userRequestRepository.getUserRequestList(
      accountRepository: accountRepository,
      authRepo: authRepo,
      ownerRepository: ownerRepository,
    );
    if (list != null) {
      if (!isClosed) {
        emit(UserRequestLoaded(list));
      }
    } else {
      emit(const UserRequestLoadFailure(error: 'Ошибка загрузки заявок'));
    }
  }
}
