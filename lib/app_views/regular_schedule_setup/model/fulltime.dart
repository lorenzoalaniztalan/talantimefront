import 'package:formz/formz.dart';

enum FulltimeValidationError { notEightHours }

class Fulltime extends FormzInput<Duration, FulltimeValidationError> {
  const Fulltime.pure([Duration? value]) : super.pure(value ?? Duration.zero);
  const Fulltime.dirty([
    super.value = Duration.zero,
  ]) : super.dirty();

  int get hours => value.inHours;

  int get minutes => value.inMinutes - hours * Duration.minutesPerHour;

  @override
  FulltimeValidationError? validator(Duration value) {
    if (value.compareTo(const Duration(hours: 8)) != 0) {
      return FulltimeValidationError.notEightHours;
    }
    return null;
  }
}
