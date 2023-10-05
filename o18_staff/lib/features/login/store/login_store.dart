import 'package:authentication_repository/authentication_repository.dart';
import 'package:mobx/mobx.dart';
import 'package:model_repository/model_repository.dart';
import 'package:validators/validators.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  final _authRepo = AuthenticationRepository();

  @observable
  Staff? currentStaff;

  @observable
  bool isLoading = false;

  @action
  Future<void> login({
    required String email,
    required String password,
  }) async {
    currentStaff = await _authRepo.login(
      email: email,
      password: password,
    );
  }

  @action
  Future<void> logout() async {
    await _authRepo.logout();
    currentStaff = null;
  }

  final FormErrorState error = FormErrorState();

  @observable
  String email = '';

  @observable
  String password = '';

  @computed
  bool get canLogin => !error.hasErrors;

  late List<ReactionDisposer> _disposers;

  void setupValidations() {
    _disposers = [
      reaction((_) => email, validateEmail),
      reaction((_) => password, validatePassword),
    ];
  }

  @action
  void validatePassword(String value) => error.password = isNull(value) || value.isEmpty ? 'Cannot be blank' : null;

  @action
  void validateEmail(String value) => error.email = isEmail(value) ? null : 'Not a valid email';

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  void validateAll() {
    validatePassword(password);
    validateEmail(email);
  }
}

class FormErrorState = _FormErrorState with _$FormErrorState;

abstract class _FormErrorState with Store {
  @observable
  String? email;

  @observable
  String? password;

  @computed
  bool get hasErrors => email != null || password != null;
}
