// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin.weekly.stat.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminWeeklyStatDto _$AdminWeeklyStatDtoFromJson(Map<String, dynamic> json) =>
    AdminWeeklyStatDto(
      json['date'] == null ? null : DateTime.parse(json['date'] as String),
      (json['totalHours'] as num?)?.toDouble(),
      (json['totalincome'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$AdminWeeklyStatDtoToJson(AdminWeeklyStatDto instance) =>
    <String, dynamic>{
      'totalHours': instance.totalHours,
      'totalincome': instance.totalincome,
      'date': instance.date?.toIso8601String(),
    };
