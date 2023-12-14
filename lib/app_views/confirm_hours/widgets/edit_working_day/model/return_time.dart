import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:turnotron/utils/time_utils.dart';

enum ReturnTimeValidationError { empty, isBeforeBreak }

class ReturnTime extends FormzInput<TimeOfDay, ReturnTimeValidationError> {
  const ReturnTime.pure([TimeOfDay? value])
      : breakTime = null,
        super.pure(value ?? const TimeOfDay(hour: 0, minute: 0));
  const ReturnTime.dirty([
    this.breakTime,
    super.value = const TimeOfDay(hour: 0, minute: 0),
  ]) : super.dirty();
  final TimeOfDay? breakTime;

  @override
  ReturnTimeValidationError? validator(TimeOfDay value) {
    if (breakTime != null && !happensBefore(breakTime!, value)) {
      return ReturnTimeValidationError.isBeforeBreak;
    }
    return null;
  }
}
