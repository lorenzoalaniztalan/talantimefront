import 'package:common_models_repository/common_models_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

/// {@template schedule_hours_item}
/// A single `schedule_hours`.
///
/// Contains a [startTime], [breakTime], [returnTime] and [finishTime].
///
/// [ScheduleHours]s are immutable and can be copied using [copyWith],
/// in addition to being serialized using [toJson].
/// {@endtemplate}
@immutable
@JsonSerializable()
abstract class ScheduleHours<T> extends Equatable {
  /// {@macro schedule_hours_item}
  const ScheduleHours({
    required this.startTime,
    required this.breakTime,
    required this.returnTime,
    required this.finishTime,
  });

  /// The check in time
  final T startTime;

  /// The check in time
  final T breakTime;

  /// The check in time
  final T returnTime;

  /// The check in time
  final T finishTime;

  /// Returns a copy of this `schedule_hours` with the given values updated.
  ///
  /// {@macro schedule_hours_item}
  ScheduleHours<T> copyWith({
    T? startTime,
    T? breakTime,
    T? returnTime,
    T? finishTime,
  });

  /// Converts this [ScheduleHours] into a [JsonMap].
  JsonMap toJson();

  @override
  List<T> get props => [startTime, breakTime, returnTime, finishTime];
}
