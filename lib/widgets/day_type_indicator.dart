import 'package:flutter/material.dart';
import 'package:schedule_api/schedule_api.dart';
import 'package:talan_tools/talan_tools.dart';

class ScheduleDayTypeIndicator extends StatelessWidget {
  const ScheduleDayTypeIndicator({required this.day, super.key});
  final ScheduleDay? day;

  @override
  Widget build(BuildContext context) {
    if (day.runtimeType == WorkingDay) {
      return TalanText.bodySmall(
        text: '8h',
        style: TextStyle(
          color: (day?.confirmed ?? false)
              ? TalanAppColors.success
              : TalanAppColors.callToAction,
        ),
      );
    }
    if (day.runtimeType == AbsenceDay) {
      return TalanText.bodySmall(
        text: 'A',
        style: TextStyle(color: TalanAppColors.primary),
      );
    }
    if (day.runtimeType == NonWorkingDay) {
      return TalanText.bodySmall(
        text: 'F',
        style: TextStyle(color: TalanAppColors.primary),
      );
    }
    return const SizedBox.shrink();
  }
}
