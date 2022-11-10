// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner.monthly.stat.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OwnerMonthlyStatDto _$OwnerMonthlyStatDtoFromJson(Map<String, dynamic> json) =>
    OwnerMonthlyStatDto(
      json['totalVisit'] as int?,
      (json['totalHours'] as num?)?.toDouble(),
      (json['totalincome'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$OwnerMonthlyStatDtoToJson(
        OwnerMonthlyStatDto instance) =>
    <String, dynamic>{
      'totalVisit': instance.totalVisit,
      'totalHours': instance.totalHours,
      'totalincome': instance.totalincome,
    };
