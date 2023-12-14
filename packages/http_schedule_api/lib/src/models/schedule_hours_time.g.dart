// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_hours_time.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleHoursTime _$ScheduleHoursTimeFromJson(Map<String, dynamic> json) =>
    ScheduleHoursTime(
      startTime: TimeOfDaySerializable.parse(
        json['start_one'] as String,
      ),
      breakTime: TimeOfDaySerializable.parse(
        json['finish_one'] as String,
      ),
      returnTime: TimeOfDaySerializable.parse(
        json['start_two'] as String,
      ),
      finishTime: TimeOfDaySerializable.parse(
        json['finish_two'] as String,
      ),
    );

Map<String, dynamic> _$ScheduleHoursTimeToJson(ScheduleHoursTime instance) =>
    <String, dynamic>{
      'start_one': instance.startTime.toString(),
      'finish_one': instance.breakTime.toString(),
      'start_two': instance.returnTime.toString(),
      'finish_two': instance.finishTime.toString(),
    };
