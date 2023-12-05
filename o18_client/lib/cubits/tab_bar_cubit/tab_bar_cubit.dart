import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:database_repository/database_repository.dart';
import 'package:equatable/equatable.dart';

part 'tab_bar_state.dart';

class TabBarCubit extends Cubit<TabBarState> {
  final AuthRepository authRepo;
  final OwnerRepository ownerRepository;
  final FlatRepository flatRepository;
  final HouseRepository houseRepository;
  final AccountRepository accountRepository;
  final CounterRepository counterRepository;
  final ImageRepository imageFileRepository;
  final RequestNumberRepository requestNumberRepository;
  final UserRequestRepository userRequestRepository;

  TabBarCubit({
    required this.authRepo,
    required this.ownerRepository,
    required this.flatRepository,
    required this.houseRepository,
    required this.accountRepository,
    required this.counterRepository,
    required this.imageFileRepository,
    required this.requestNumberRepository,
    required this.userRequestRepository,
  }) : super(TabBarInitial());
}
