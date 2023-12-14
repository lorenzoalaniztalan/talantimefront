import 'package:common_models_repository/common_models_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

/// {@template absence_day_item}
/// A single `absence_day`.
///
/// Contains a [day], [month] and [year].
///
/// [ScheduleDay]s are immutable and can be copied using [copyWith], in addition
/// to being serialized using [toJson].
/// {@endtemplate}
@immutable
@JsonSerializable()
abstract class ScheduleDay extends Equatable {
  /// {@macro absence_day_item}
  const ScheduleDay({
    required this.day,
    required this.month,
    required this.year,
    this.confirmed,
  });

  /// Day of the month
  final int day;

  /// Numeric month of this absence
  final int month;

  /// YYYY year of this absence
  final int year;

  /// is schedule day confirmed
  final bool? confirmed;

  /// Returns a copy of this `absence_day` with the given values updated.
  ///
  /// {@macro absence_day_item}
  ScheduleDay copyWith();

  /// Converts this [ScheduleDay] into a [DateTime].
  DateTime toDateTime() => DateTime(year, month, day);

  /// Converts this [ScheduleDay] into a [JsonMap].
  JsonMap toJson();

  @override
  List<Object> get props => [day, month, year];
}
