import 'package:formz/formz.dart';

enum RegistrationDateValidationError { empty, format, talanInvalid }

class RegistrationDate
    extends FormzInput<DateTime?, RegistrationDateValidationError> {
  const RegistrationDate.pure(super.value) : super.pure();
  const RegistrationDate.dirty([super.value]) : super.dirty();

  @override
  RegistrationDateValidationError? validator(DateTime? value) {
    if (value == null) {
      return RegistrationDateValidationError.empty;
    }
    return null;
  }
}
