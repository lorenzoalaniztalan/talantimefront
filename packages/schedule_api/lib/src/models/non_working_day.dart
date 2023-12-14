import 'package:common_models_repository/common_models_repository.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:schedule_api/schedule_api.dart';

part 'non_working_day.g.dart';

/// {@template absence_day_item}
/// A single `absence_day`.
///
/// Contains a [day], [month], [year].
///
/// [NonWorkingDay]s are immutable and can be copied using [copyWith], in addition
/// to being serialized and deserialized using [toJson] and [fromJson]
/// respectively.
/// {@endtemplate}
@immutable
@JsonSerializable()
class NonWorkingDay extends ScheduleDay {
  /// {@macro absence_day_item}
  const NonWorkingDay({
    required super.day,
    required super.month,
    required super.year,
  });

  /// Returns a copy of this `absence_day` with the given values updated.
  ///
  /// {@macro absence_day_item}
  @override
  NonWorkingDay copyWith({
    int? id,
    int? day,
    int? month,
    int? year,
  }) {
    return NonWorkingDay(
      day: day ?? this.day,
      month: month ?? this.month,
      year: year ?? this.year,
    );
  }

  /// Deserializes the given [JsonMap] into a [NonWorkingDay].
  static NonWorkingDay fromJson(JsonMap json) => _$NonWorkingDayFromJson(json);

  /// Converts this [NonWorkingDay] into a [JsonMap].
  @override
  JsonMap toJson() => _$NonWorkingDayToJson(this);

  @override
  List<Object> get props => [day, month, year];
}
