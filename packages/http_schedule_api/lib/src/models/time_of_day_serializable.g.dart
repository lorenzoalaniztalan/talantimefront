// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_of_day_serializable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeOfDaySerializable _$TimeOfDaySerializableFromJson(
  Map<String, dynamic> json,
) =>
    TimeOfDaySerializable(
      hour: json['hour'] as int,
      minute: json['minute'] as int,
    );

Map<String, dynamic> _$TimeOfDaySerializableToJson(
  TimeOfDaySerializable instance,
) =>
    <String, dynamic>{
      'hour': instance.hour,
      'minute': instance.minute,
    };
