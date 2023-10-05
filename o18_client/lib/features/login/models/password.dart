import 'package:formz/formz.dart';

/// Validation errors for the [Password] [FormzInput].
enum PasswordValidationError {
  /// Generic invalid error.
  invalid,
}

/// Form input for an password input.
class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([
    String value = '',
  ]) : super.dirty(value);

  static final _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$',
  );

  @override
  PasswordValidationError? validator(String? value) =>
      _passwordRegExp.hasMatch(value ?? '') ? null : PasswordValidationError.invalid;
}
