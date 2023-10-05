import 'package:database_repository/database_repository.dart';
import 'package:mobx/mobx.dart';
part 'registration_store.g.dart';

class Registration = _RegistrationBase with _$Registration;

abstract class _RegistrationBase with Store {
  final _ownerRepository = OwnerRepository();
  final _flatRepository = FlatRepository();
  final _houseRepository = HouseRepository();
  final _accountRepository = AccountRepository();

  @observable
  bool isLoading = false;

  @observable
  bool isUserCreated = false;
}
