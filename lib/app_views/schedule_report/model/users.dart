import 'package:formz/formz.dart';

enum UserlistValidationError { empty }

class Userlist extends FormzInput<List<int>, UserlistValidationError> {
  const Userlist.pure() : super.pure(const []);
  const Userlist.dirty(super.value) : super.dirty();

  @override
  UserlistValidationError? validator(List<int>? value) {
    if (value == null || value.isEmpty) {
      return UserlistValidationError.empty;
    }
    return null;
  }
}
