import 'package:email_validator/email_validator.dart';
import 'package:formz/formz.dart';

enum EmailValidationError { empty, format, talanInvalid }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([super.value = '']) : super.dirty();

  @override
  EmailValidationError? validator(String value) {
    if (value.isEmpty) {
      return EmailValidationError.empty;
    }
    if (!EmailValidator.validate(value)) {
      return EmailValidationError.format;
    }
    if (!value.endsWith('@talan.com')) {
      return EmailValidationError.talanInvalid;
    }
    return null;
  }
}
