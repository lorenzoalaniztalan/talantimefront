// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'working_day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkingDay _$WorkingDayFromJson(Map<String, dynamic> json) => WorkingDay(
      day: json['day'] as int,
      month: json['month'] as int,
      year: json['year'] as int,
      startOne: json['start_one'] as String,
      finishOne: json['finish_one'] as String,
      startTwo: json['start_two'] as String,
      finishTwo: json['finish_two'] as String,
      confirmed: json['confirmed'] != null ? json['confirmed'] as bool : false,
    );

Map<String, dynamic> _$WorkingDayToJson(WorkingDay instance) =>
    <String, dynamic>{
      'day': instance.day,
      'month': instance.month,
      'year': instance.year,
      'start_one': instance.startOne,
      'finish_one': instance.finishOne,
      'start_two': instance.startTwo,
      'finish_two': instance.finishTwo,
      'confirmed': instance.confirmed,
    };
