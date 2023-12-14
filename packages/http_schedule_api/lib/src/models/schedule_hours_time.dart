import 'package:common_models_repository/common_models_repository.dart';
import 'package:flutter/material.dart';
import 'package:http_schedule_api/http_schedule_api.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:schedule_api/schedule_api.dart';

part 'schedule_hours_time.g.dart';

/// {@template schedule_hours_item}
/// A single `schedule_hours`.
///
/// Contains a [startTime], [breakTime], [returnTime] and [finishTime].
///
/// [ScheduleHoursTime]s are immutable and can be copied using [copyWith],
/// in addition to being serialized and deserialized using [toJson] and
/// [fromJson] respectively.
/// {@endtemplate}
@immutable
@JsonSerializable()
class ScheduleHoursTime extends ScheduleHours<TimeOfDaySerializable> {
  /// {@macro schedule_hours_item}
  const ScheduleHoursTime({
    required super.startTime,
    required super.breakTime,
    required super.returnTime,
    required super.finishTime,
  });

  /// Returns a copy of this `schedule_hours` with the given values updated.
  ///
  /// {@macro schedule_hours_item}
  @override
  ScheduleHoursTime copyWith({
    TimeOfDaySerializable? startTime,
    TimeOfDaySerializable? breakTime,
    TimeOfDaySerializable? returnTime,
    TimeOfDaySerializable? finishTime,
  }) {
    return ScheduleHoursTime(
      startTime: startTime ?? this.startTime,
      breakTime: breakTime ?? this.breakTime,
      returnTime: returnTime ?? this.returnTime,
      finishTime: finishTime ?? this.finishTime,
    );
  }

  /// Deserializes the given [JsonMap] into a [ScheduleHoursTime].
  static ScheduleHoursTime fromJson(JsonMap json) =>
      _$ScheduleHoursTimeFromJson(json);

  /// Converts this [ScheduleHoursTime] into a [JsonMap].
  @override
  JsonMap toJson() => _$ScheduleHoursTimeToJson(this);

  @override
  List<TimeOfDaySerializable> get props =>
      [startTime, breakTime, returnTime, finishTime];
}
