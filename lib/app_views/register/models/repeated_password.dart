import 'package:formz/formz.dart';

enum RepeatedPasswordValidationError { empty, noMatch }

class RepeatedPassword
    extends FormzInput<String, RepeatedPasswordValidationError> {
  const RepeatedPassword.pure()
      : originalPassword = '',
        super.pure('');
  const RepeatedPassword.dirty(this.originalPassword, [super.value = ''])
      : super.dirty();
  final String originalPassword;

  @override
  RepeatedPasswordValidationError? validator(
    String value,
  ) {
    if (value.isEmpty) return RepeatedPasswordValidationError.empty;
    if (value != originalPassword) {
      return RepeatedPasswordValidationError.noMatch;
    }
    return null;
  }
}
