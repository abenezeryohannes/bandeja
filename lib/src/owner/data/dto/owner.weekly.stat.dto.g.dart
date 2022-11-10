// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner.weekly.stat.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OwnerWeeklyStatDto _$OwnerWeeklyStatDtoFromJson(Map<String, dynamic> json) =>
    OwnerWeeklyStatDto(
      json['date'] == null ? null : DateTime.parse(json['date'] as String),
      (json['totalHours'] as num?)?.toDouble(),
      (json['totalincome'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$OwnerWeeklyStatDtoToJson(OwnerWeeklyStatDto instance) =>
    <String, dynamic>{
      'totalHours': instance.totalHours,
      'totalincome': instance.totalincome,
      'date': instance.date?.toIso8601String(),
    };
