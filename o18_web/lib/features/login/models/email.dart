import 'package:formz/formz.dart';

/// Validation errors for the [Email] [FormzInput].
enum EmailValidationError {
  /// Generic invalid error.
  invalid,
}

/// Form input for an email input.
class Email extends FormzInput<String, EmailValidationError> with FormzInputErrorCacheMixin {
  Email.pure([super.value = '']) : super.pure();
  Email.dirty([super.value = '']) : super.dirty();

  static final _emailRegExp = RegExp(
    r'^[a-zA-Z\d.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z\d-]+(?:\.[a-zA-Z\d-]+)*$',
  );

  @override
  EmailValidationError? validator(
    String value,
  ) =>
      _emailRegExp.hasMatch(value) ? null : EmailValidationError.invalid;
}

extension on EmailValidationError {
  String text() {
    switch (this) {
      case EmailValidationError.invalid:
        return 'Please ensure the email entered is valid';
    }
  }
}
