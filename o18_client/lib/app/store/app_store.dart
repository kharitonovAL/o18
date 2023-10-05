import 'package:authentication_repository/authentication_repository.dart';
import 'package:mobx/mobx.dart';
part 'app_store.g.dart';

class AppStore = _AppStore with _$AppStore;

abstract class _AppStore with Store {
  @observable
  AuthenticationStatus status = AuthenticationStatus.unauthenticated;
}
