import 'package:formz/formz.dart';

enum EmployeeIdValidationError { empty, format }

class EmployeeId extends FormzInput<String, EmployeeIdValidationError> {
  const EmployeeId.pure() : super.pure('');
  const EmployeeId.dirty([super.value = '']) : super.dirty();

  @override
  EmployeeIdValidationError? validator(String value) {
    if (value.isEmpty) return EmployeeIdValidationError.empty;
    return null;
  }
}
