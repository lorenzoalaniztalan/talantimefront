import 'package:formz/formz.dart';

enum OfficeCodeValidationError { empty }

class OfficeCode extends FormzInput<String, OfficeCodeValidationError> {
  const OfficeCode.pure() : super.pure('');
  const OfficeCode.dirty([super.value = '']) : super.dirty();

  @override
  OfficeCodeValidationError? validator(String value) {
    if (value.isEmpty) return OfficeCodeValidationError.empty;
    return null;
  }
}
