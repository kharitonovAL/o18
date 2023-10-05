part of 'login_cubit.dart';

class LoginState with FormzMixin {
  LoginState({
    this.password = const Password.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.errorCode,
    this.userRole = UserRole.mcOperator,
    Email? email,
  }) : email = email ?? Email.pure();

  final Email email;
  final Password password;
  final FormzSubmissionStatus status;
  final int? errorCode;
  final String userRole;

  LoginState copyWith({
    Email? email,
    Password? password,
    FormzSubmissionStatus? status,
    int? errorCode,
    String? userRole,
  }) =>
      LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status,
        errorCode: errorCode ?? this.errorCode,
        userRole: userRole ?? this.userRole,
      );

  @override
  List<FormzInput> get inputs => [email, password];
}
