import 'package:common_models_repository/common_models_repository.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:schedule_api/schedule_api.dart';

part 'working_day.g.dart';

/// {@template working_day_item}
/// A single `working_day`.
///
/// Contains a [day], [month], [year], [startOne], [finishOne], [startTwo]
/// and [finishTwo].
///
/// [WorkingDay]s are immutable and can be copied using [copyWith], in addition
/// to being serialized and deserialized using [toJson] and [fromJson]
/// respectively.
/// {@endtemplate}
@immutable
@JsonSerializable()
class WorkingDay extends ScheduleDay {
  /// {@macro working_day_item}
  const WorkingDay({
    required super.day,
    required super.month,
    required super.year,
    required this.startOne,
    required this.finishOne,
    required this.startTwo,
    required this.finishTwo,
    super.confirmed,
  });

  /// The starting time of the first working session for a day (mornings).
  ///
  /// Format HH:MM.
  final String startOne;

  /// The finish time of the first working session for a day (mornings).
  ///
  /// Format HH:MM.
  final String finishOne;

  /// The starting time of the second working session for a day (afternoons).
  ///
  /// Format HH:MM.
  final String startTwo;

  /// The finish time of the second working session for a day (afternoons).
  ///
  /// Format HH:MM.
  final String finishTwo;

  /// Returns a copy of this `working_day` with the given values updated.
  ///
  /// {@macro working_day_item}
  @override
  WorkingDay copyWith({
    int? day,
    int? month,
    int? year,
    String? startOne,
    String? finishOne,
    String? startTwo,
    String? finishTwo,
    bool? confirmed,
  }) {
    return WorkingDay(
      day: day ?? this.day,
      month: month ?? this.month,
      year: year ?? this.year,
      startOne: startOne ?? this.startOne,
      finishOne: finishOne ?? this.finishOne,
      startTwo: startTwo ?? this.startTwo,
      finishTwo: finishTwo ?? this.finishTwo,
      confirmed: confirmed ?? this.confirmed,
    );
  }

  /// Deserializes the given [JsonMap] into a [WorkingDay].
  static WorkingDay fromJson(JsonMap json) => _$WorkingDayFromJson(json);

  /// Converts this [WorkingDay] into a [JsonMap].
  @override
  JsonMap toJson() => _$WorkingDayToJson(this);

  @override
  List<Object> get props =>
      [day, month, year, startOne, finishOne, startTwo, finishTwo];
}
