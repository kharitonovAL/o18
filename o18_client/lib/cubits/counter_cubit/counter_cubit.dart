import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:database_repository/database_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:model_repository/model_repository.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  final AuthRepository authRepo;
  final OwnerRepository ownerRepository;
  final FlatRepository flatRepository;
  final AccountRepository accountRepository;
  final CounterRepository counterRepository;

  CounterCubit({
    required this.authRepo,
    required this.ownerRepository,
    required this.flatRepository,
    required this.accountRepository,
    required this.counterRepository,
  }) : super(CounterInitial()) {
    loadCounterList(
      authRepo: authRepo,
      ownerRepository: ownerRepository,
      flatRepository: flatRepository,
      accountRepository: accountRepository,
      counterRepository: counterRepository,
    );
  }

  Future<void> loadCounterList({
    required AuthRepository authRepo,
    required OwnerRepository ownerRepository,
    required FlatRepository flatRepository,
    required AccountRepository accountRepository,
    required CounterRepository counterRepository,
  }) async {
    emit(CounterLoading());
    final list = await counterRepository.counterList(
      authRepo: authRepo,
      ownerRepository: ownerRepository,
      accountRepository: accountRepository,
      flatRepository: flatRepository,
    );

    if (list != null) {
      if (!isClosed) {
        emit(CounterLoaded(list));
      }
    } else {
      emit(const CounterLoadFailure(error: 'Ошибка загрузки счетсчиков'));
    }
  }
}
