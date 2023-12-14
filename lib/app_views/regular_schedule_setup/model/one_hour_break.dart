import 'package:formz/formz.dart';

enum OneHourBreakValidationError { notOneHour }

class OneHourBreak extends FormzInput<Duration, OneHourBreakValidationError> {
  const OneHourBreak.pure([Duration? value])
      : super.pure(value ?? Duration.zero);
  const OneHourBreak.dirty([
    super.value = Duration.zero,
  ]) : super.dirty();

  int get hours => value.inHours;

  int get minutes => value.inMinutes - hours * Duration.minutesPerHour;

  @override
  OneHourBreakValidationError? validator(Duration value) {
    if (value.compareTo(const Duration(hours: 1)) != 0) {
      return OneHourBreakValidationError.notOneHour;
    }
    return null;
  }
}
