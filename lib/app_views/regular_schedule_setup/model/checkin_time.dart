import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

enum CheckinTimeValidationError { empty }

class CheckinTime extends FormzInput<TimeOfDay, CheckinTimeValidationError> {
  const CheckinTime.pure([TimeOfDay? value])
      : super.pure(value ?? const TimeOfDay(hour: 0, minute: 0));
  const CheckinTime.dirty([super.value = const TimeOfDay(hour: 0, minute: 0)])
      : super.dirty();

  @override
  CheckinTimeValidationError? validator(TimeOfDay value) {
    return null;
  }
}
