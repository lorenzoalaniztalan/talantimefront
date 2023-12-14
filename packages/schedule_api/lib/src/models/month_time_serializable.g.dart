// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'month_time_serializable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MonthTimeSerializable _$MonthTimeSerializableFromJson(
  Map<String, dynamic> json,
) =>
    MonthTimeSerializable(
      month: json['month'] as int,
      year: json['year'] as int,
    );

Map<String, dynamic> _$MonthTimeSerializableToJson(
  MonthTimeSerializable instance,
) =>
    <String, dynamic>{
      'year': instance.year,
      'month': instance.month,
    };
