import 'package:common_models_repository/common_models_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'absence_type.g.dart';

/// {@template absenceType_item}
/// A single `absenceType`.
///
/// Contains a [id], [name] and [code].
///
/// [AbsenceType]s are immutable and serialized and deserialized using [toJson] and [fromJson]
/// respectively.
/// {@endtemplate}
@immutable
@JsonSerializable()
class AbsenceType extends Equatable {
  /// A regular absenceType
  const AbsenceType({
    required this.id,
    required this.name,
    required this.code,
  });

  /// Unique identifier
  final int id;

  /// The absenceType name.
  final String name;

  /// The absenceType code
  final String code;

  @override
  List<Object> get props => [
        id,
        name,
        code,
      ];

  /// Deserializes the given [JsonMap] into a [AbsenceType].
  static AbsenceType fromJson(JsonMap json) => _$AbsenceTypeFromJson(json);

  /// Converts this [AbsenceType] into a [JsonMap].
  JsonMap toJson() => _$AbsenceTypeToJson(this);
}
