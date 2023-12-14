import 'package:common_models_repository/common_models_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:schedule_api/schedule_api.dart';

part 'month_schedule_response.g.dart';

/// {@template schedule_item}
/// A single `schedule` item.
///
/// [MonthSchedule]s are immutable and can be copied using [copyWith], in
/// addition to being serialized and deserialized using [toJson] and [fromJson]
/// respectively.
/// {@endtemplate}
@immutable
@JsonSerializable()
class MonthSchedule extends Equatable {
  /// {@macro schedule_item}
  const MonthSchedule({
    required this.draft,
    required this.absences,
    required this.nonWorkingDays,
    required this.schedule,
  });

  /// Whether this month is a confirmed month or just a draft ready to be
  /// confirmed.
  final bool draft;

  /// Collection of absences.
  final Map<String, AbsenceDay> absences;

  /// List of non working days for a given month and year.
  final List<int> nonWorkingDays;

  /// Collection of working days.
  final Map<String, WorkingDay> schedule;

  /// Returns a copy of this `MonthSchedule` with the given values updated.
  ///
  /// {@macro schedule_item}
  MonthSchedule copyWith({
    bool? draft,
    Map<String, AbsenceDay>? absences,
    List<int>? nonWorkingDays,
    Map<String, WorkingDay>? schedule,
  }) {
    return MonthSchedule(
      draft: draft ?? this.draft,
      absences: absences ?? this.absences,
      nonWorkingDays: nonWorkingDays ?? this.nonWorkingDays,
      schedule: schedule ?? this.schedule,
    );
  }

  /// Deserializes the given [JsonMap] into a [MonthSchedule].
  static MonthSchedule fromJson(JsonMap json) => _$MonthScheduleFromJson(json);

  /// Converts this [MonthSchedule] into a [JsonMap].
  JsonMap toJson() => _$MonthScheduleToJson(this);

  @override
  List<Object> get props => [draft, absences, nonWorkingDays, schedule];
}
