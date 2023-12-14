import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:turnotron/utils/time_utils.dart';

enum BreakTimeValidationError { empty, isBeforeCheckin }

class BreakTime extends FormzInput<TimeOfDay, BreakTimeValidationError> {
  const BreakTime.pure([TimeOfDay? value])
      : checkinTime = null,
        super.pure(value ?? const TimeOfDay(hour: 0, minute: 0));
  const BreakTime.dirty([
    this.checkinTime,
    super.value = const TimeOfDay(hour: 0, minute: 0),
  ]) : super.dirty();
  final TimeOfDay? checkinTime;

  @override
  BreakTimeValidationError? validator(TimeOfDay value) {
    if (checkinTime != null && !happensBefore(checkinTime!, value)) {
      return BreakTimeValidationError.isBeforeCheckin;
    }
    return null;
  }
}
