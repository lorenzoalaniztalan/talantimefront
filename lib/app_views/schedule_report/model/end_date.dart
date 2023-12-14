import 'package:formz/formz.dart';

enum EndDateValidationError { empty }

class EndDate extends FormzInput<DateTime, EndDateValidationError> {
  const EndDate.pure(super.value) : super.pure();
  const EndDate.dirty(super.value) : super.dirty();

  @override
  EndDateValidationError? validator(DateTime? value) {
    if (value == null) {
      return EndDateValidationError.empty;
    }
    return null;
  }
}
