import 'package:flutter/material.dart';

bool areSameMonthAndYear(DateTime a, DateTime b) =>
    a.month == b.month && a.year == b.year;

bool happensBefore(TimeOfDay a, TimeOfDay b) =>
    (a.hour * 60 + a.minute) < (b.hour * 60 + b.minute);

Duration totalSumOfHours({
  required TimeOfDay checkinTime,
  required TimeOfDay breakTime,
  required TimeOfDay returnTime,
  required TimeOfDay checkoutTime,
}) {
  final firstHalf = hoursDifference(breakTime, checkinTime);
  final secondHalf = hoursDifference(checkoutTime, returnTime);
  final totalMinutes = firstHalf + secondHalf;
  final hours = (totalMinutes / Duration.minutesPerHour).floor();
  final minutes = totalMinutes - hours * Duration.minutesPerHour;
  return Duration(hours: hours, minutes: minutes);
}

/// Total minutes between a and b. A negative value means that moment [a]
/// happens before moment [b].
int hoursDifference(TimeOfDay a, TimeOfDay b) {
  return (a.hour * Duration.minutesPerHour + a.minute) -
      (b.hour * Duration.minutesPerHour + b.minute);
}

DateTime firstDayOfMonth(DateTime date) => DateTime(date.year, date.month);

DateTime lastDayOfMonth(DateTime date) =>
    DateTime(date.year, date.month + 1, 0);
