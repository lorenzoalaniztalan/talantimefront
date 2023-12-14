import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:turnotron/utils/time_utils.dart';

enum CheckoutTimeValidationError { empty, isBeforeCheckout }

class CheckoutTime extends FormzInput<TimeOfDay, CheckoutTimeValidationError> {
  const CheckoutTime.pure([TimeOfDay? value])
      : returnTime = null,
        super.pure(value ?? const TimeOfDay(hour: 0, minute: 0));
  const CheckoutTime.dirty([
    this.returnTime,
    super.value = const TimeOfDay(hour: 0, minute: 0),
  ]) : super.dirty();
  final TimeOfDay? returnTime;

  @override
  CheckoutTimeValidationError? validator(TimeOfDay value) {
    if (returnTime != null && !happensBefore(returnTime!, value)) {
      return CheckoutTimeValidationError.isBeforeCheckout;
    }
    return null;
  }
}
