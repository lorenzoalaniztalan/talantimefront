import 'package:common_models_repository/common_models_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'month_time_serializable.g.dart';

/// {@template month_time_serializable_item}
/// A single `month_time_serializable`.
///
/// Contains a [month] and [year].
///
/// [MonthTimeSerializable]s are immutable and can be copied using [copyWith],
/// in addition to being serialized and deserialized using [toJson] and
/// [fromJson] respectively.
/// {@endtemplate}
@immutable
@JsonSerializable()
class MonthTimeSerializable extends DateTime with EquatableMixin {
  /// {@macro month_time_serializable_item}
  MonthTimeSerializable({required int month, required int year})
      : super(year, month);

  /// Parses the given [String] into a [MonthTimeSerializable].
  factory MonthTimeSerializable.fromDateTime(DateTime time) {
    return MonthTimeSerializable(month: time.month, year: time.year);
  }

  /// Returns a copy of this `schedule_hours` with the given values updated.
  ///
  /// {@macro schedule_hours_item}
  MonthTimeSerializable copyWith({
    int? month,
    int? year,
  }) {
    return MonthTimeSerializable(
      month: month ?? this.month,
      year: year ?? this.year,
    );
  }

  /// Deserializes the given [JsonMap] into a [MonthTimeSerializable].
  static MonthTimeSerializable fromJson(JsonMap json) =>
      _$MonthTimeSerializableFromJson(json);

  /// Converts this [MonthTimeSerializable] into a [JsonMap].
  JsonMap toJson() => _$MonthTimeSerializableToJson(this);

  @override
  List<Object?> get props => [month, year];
}
