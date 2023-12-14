// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'absence_day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AbsenceDay _$AbsenceDayFromJson(Map<String, dynamic> json) => AbsenceDay(
      day: json['day'] as int,
      month: json['month'] as int,
      year: json['year'] as int,
      type: AbsenceType.fromJson(json['type'] as JsonMap),
    );

Map<String, dynamic> _$AbsenceDayToJson(AbsenceDay instance) =>
    <String, dynamic>{
      'day': instance.day,
      'month': instance.month,
      'year': instance.year,
      'type': instance.type?.id,
    };
