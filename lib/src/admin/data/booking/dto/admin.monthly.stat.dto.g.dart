// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin.monthly.stat.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminMonthlyStatDto _$AdminMonthlyStatDtoFromJson(Map<String, dynamic> json) =>
    AdminMonthlyStatDto(
      json['totalVisit'] as int?,
      (json['totalHours'] as num?)?.toDouble(),
      (json['totalincome'] as num?)?.toDouble(),
    )
      ..allHours = (json['allHours'] as num?)?.toDouble()
      ..bookedHours = (json['bookedHours'] as num?)?.toDouble()
      ..appVisitsCount = (json['appVisitsCount'] as num?)?.toDouble()
      ..newUserCount = (json['newUserCount'] as num?)?.toDouble()
      ..padelsCount = (json['padelsCount'] as num?)?.toDouble();

Map<String, dynamic> _$AdminMonthlyStatDtoToJson(
        AdminMonthlyStatDto instance) =>
    <String, dynamic>{
      'totalVisit': instance.totalVisit,
      'allHours': instance.allHours,
      'totalHours': instance.totalHours,
      'bookedHours': instance.bookedHours,
      'totalincome': instance.totalincome,
      'appVisitsCount': instance.appVisitsCount,
      'newUserCount': instance.newUserCount,
      'padelsCount': instance.padelsCount,
    };
