import 'package:common_models_repository/common_models_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'office.g.dart';

/// {@template office_item}
/// A single `office`.
///
/// Contains a [id], [name] and [code].
///
/// [Office]s are immutable and serialized and deserialized using [toJson] and [fromJson]
/// respectively.
/// {@endtemplate}
@immutable
@JsonSerializable()
class Office extends Equatable {
  /// A regular office
  const Office({
    required this.id,
    required this.name,
    required this.code,
  });

  /// Unique identifier
  final int id;

  /// The office name.
  final String name;

  /// The office code
  final String code;

  @override
  List<Object> get props => [
        id,
        name,
        code,
      ];

  /// Deserializes the given [JsonMap] into a [Office].
  static Office fromJson(JsonMap json) => _$OfficeFromJson(json);

  /// Converts this [Office] into a [JsonMap].
  JsonMap toJson() => _$OfficeToJson(this);
}
