import 'package:formz/formz.dart';

/// Validation errors for the [ConfirmedPassword] [FormzInput].
enum ConfirmedPasswordValidationError {
  /// Generic invalid error.
  invalid,
}

/// Form input for a confirmed password input.
class ConfirmedPassword
    extends FormzInput<String, ConfirmedPasswordValidationError> {
  const ConfirmedPassword.pure({
    this.password = '',
  }) : super.pure('');

  const ConfirmedPassword.dirty({
    required this.password,
    String value = '',
  }) : super.dirty(value);

  /// The original password.
  final String password;

  @override
  ConfirmedPasswordValidationError? validator(
    String? value,
  ) =>
      password == value ? null : ConfirmedPasswordValidationError.invalid;
}
