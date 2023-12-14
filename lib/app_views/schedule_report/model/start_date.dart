import 'package:formz/formz.dart';

enum StartDateValidationError { empty }

class StartDate extends FormzInput<DateTime, StartDateValidationError> {
  const StartDate.pure(super.value) : super.pure();
  const StartDate.dirty(super.value) : super.dirty();

  @override
  StartDateValidationError? validator(DateTime? value) {
    if (value == null) {
      return StartDateValidationError.empty;
    }
    return null;
  }
}
