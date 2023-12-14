// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'month_working_schedule_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MonthHistorySchedule _$MonthWorkingScheduleFromJson(
  Map<String, dynamic> json,
) =>
    MonthHistorySchedule(
      absences: (json['absences'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, AbsenceDay.fromJson(e as Map<String, dynamic>)),
      ),
      nonWorkingDays: (json['non_working_days'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      schedule: (json['schedule'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, WorkingDay.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$MonthWorkingScheduleToJson(
  MonthHistorySchedule instance,
) =>
    <String, dynamic>{
      'absences': instance.absences,
      'non_working_days': instance.nonWorkingDays,
      'schedule': instance.schedule,
    };
