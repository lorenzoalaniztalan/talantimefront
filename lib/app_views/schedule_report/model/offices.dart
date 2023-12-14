import 'package:formz/formz.dart';

enum OfficelistValidationError { empty }

class Officelist extends FormzInput<List<String>, OfficelistValidationError> {
  const Officelist.pure() : super.pure(const []);
  const Officelist.dirty(super.value) : super.dirty();

  @override
  OfficelistValidationError? validator(List<String> value) {
    return null;
  }
}
