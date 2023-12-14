import 'package:common_models_repository/common_models_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:schedule_api/schedule_api.dart';

part 'month_working_schedule_response.g.dart';

/// {@template schedule_item}
/// A single `schedule` item.
///
/// [MonthHistorySchedule]s are immutable and can be copied using [copyWith], in
/// addition to being serialized and deserialized using [toJson] and [fromJson]
/// respectively.
/// {@endtemplate}
@immutable
@JsonSerializable()
class MonthHistorySchedule extends Equatable {
  /// {@macro schedule_item}
  const MonthHistorySchedule({
    required this.absences,
    required this.nonWorkingDays,
    required this.schedule,
  });

  /// Collection of absences.
  final Map<String, AbsenceDay> absences;

  /// List of non working days for a given month and year.
  final List<int> nonWorkingDays;

  /// Collection of working days.
  final Map<String, WorkingDay> schedule;

  /// Returns a copy of this `MonthHistorySchedule` with the given values updated.
  ///
  /// {@macro schedule_item}
  MonthHistorySchedule copyWith({
    Map<String, AbsenceDay>? absences,
    List<int>? nonWorkingDays,
    Map<String, WorkingDay>? schedule,
  }) {
    return MonthHistorySchedule(
      absences: absences ?? this.absences,
      nonWorkingDays: nonWorkingDays ?? this.nonWorkingDays,
      schedule: schedule ?? this.schedule,
    );
  }

  /// Deserializes the given [JsonMap] into a [MonthHistorySchedule].
  static MonthHistorySchedule fromJson(JsonMap json) =>
      _$MonthWorkingScheduleFromJson(json);

  /// Converts this [MonthHistorySchedule] into a [JsonMap].
  JsonMap toJson() => _$MonthWorkingScheduleToJson(this);

  @override
  List<Object> get props => [schedule];
}
