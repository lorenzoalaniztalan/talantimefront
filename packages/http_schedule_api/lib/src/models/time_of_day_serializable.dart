import 'package:common_models_repository/common_models_repository.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'time_of_day_serializable.g.dart';

/// {@template time_of_day_serializable_item}
/// A single `time_of_day_serializable`.
///
/// Contains a [hour] and [minute].
///
/// [TimeOfDaySerializable]s are immutable and can be copied using [copyWith],
/// in addition to being serialized and deserialized using [toJson] and
/// [fromJson] respectively.
/// {@endtemplate}
@immutable
@JsonSerializable()
class TimeOfDaySerializable extends TimeOfDay {
  /// {@macro time_of_day_serializable_item}
  const TimeOfDaySerializable({required super.hour, required super.minute});

  /// Parses the given [String] into a [TimeOfDaySerializable].
  factory TimeOfDaySerializable.fromTimeOfDay(TimeOfDay time) {
    return TimeOfDaySerializable(hour: time.hour, minute: time.minute);
  }

  /// Parses the given [String] into a [TimeOfDaySerializable].
  factory TimeOfDaySerializable.parse(String time) {
    final values = time.split(':').map(int.parse).toList();
    return TimeOfDaySerializable(hour: values[0], minute: values[1]);
  }

  /// Returns a copy of this `schedule_hours` with the given values updated.
  ///
  /// {@macro schedule_hours_item}
  TimeOfDaySerializable copyWith({
    int? hour,
    int? minute,
  }) {
    return TimeOfDaySerializable(
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
    );
  }

  /// Deserializes the given [JsonMap] into a [TimeOfDaySerializable].
  static TimeOfDaySerializable fromJson(JsonMap json) =>
      _$TimeOfDaySerializableFromJson(json);

  /// Converts this [TimeOfDaySerializable] into a [JsonMap].
  JsonMap toJson() => _$TimeOfDaySerializableToJson(this);

  @override
  String toString() =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
}
