import 'package:absence_api/absence_api.dart';
import 'package:formz/formz.dart';

enum AbsenceValidationError { empty, isBeforeCheckin }

class Absence extends FormzInput<AbsenceType, AbsenceValidationError> {
  const Absence.pure([AbsenceType? value])
      : super.pure(value ?? const AbsenceType(id: -1, name: '', code: ''));
  const Absence.dirty([
    super.value = const AbsenceType(id: -1, name: '', code: ''),
  ]) : super.dirty();

  @override
  AbsenceValidationError? validator(AbsenceType? value) {
    if (value == null || value.id == -1) {
      return AbsenceValidationError.empty;
    }
    return null;
  }
}
