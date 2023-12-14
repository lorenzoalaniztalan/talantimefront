import 'package:absence_api/absence_api.dart';
import 'package:common_models_repository/common_models_repository.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:schedule_api/schedule_api.dart';

part 'absence_day.g.dart';

/// {@template absence_day_item}
/// A single `absence_day`.
///
/// Contains a [day], [month], [year] and [type].
///
/// [AbsenceDay]s are immutable and can be copied using [copyWith], in addition
/// to being serialized and deserialized using [toJson] and [fromJson]
/// respectively.
/// {@endtemplate}
@immutable
@JsonSerializable()
class AbsenceDay extends ScheduleDay {
  /// {@macro absence_day_item}
  const AbsenceDay({
    required super.day,
    required super.month,
    required super.year,
    required this.type,
  });

  /// The type of absence
  final AbsenceType? type;

  /// Returns a copy of this `absence_day` with the given values updated.
  ///
  /// {@macro absence_day_item}
  @override
  AbsenceDay copyWith({
    AbsenceType? type,
    int? day,
    int? month,
    int? year,
  }) {
    return AbsenceDay(
      type: type ?? this.type,
      day: day ?? this.day,
      month: month ?? this.month,
      year: year ?? this.year,
    );
  }

  /// Deserializes the given [JsonMap] into a [AbsenceDay].
  static AbsenceDay fromJson(JsonMap json) => _$AbsenceDayFromJson(json);

  /// Converts this [AbsenceDay] into a [JsonMap].
  @override
  JsonMap toJson() => _$AbsenceDayToJson(this);

  @override
  List<Object> get props => [day, month, year, type ?? 'noAbsenceType'];
}
