import 'package:formz/formz.dart';

/// Validation errors for the [Email] [FormzInput].
enum EmailValidationError {
  /// Generic invalid error.
  invalid,
}

/// Form input for an email input.
class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([String value = '']) : super.dirty(value);

  static final RegExp _emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+');

  @override
  EmailValidationError? validator(
    String? value,
  ) =>
      _emailRegExp.hasMatch(value ?? '') ? null : EmailValidationError.invalid;
}
