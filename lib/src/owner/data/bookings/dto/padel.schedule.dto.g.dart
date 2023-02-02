// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'padel.schedule.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PadelScheduleDto _$PadelScheduleDtoFromJson(Map<String, dynamic> json) =>
    PadelScheduleDto(
      json['id'] as int,
      json['padelId'] as int,
      json['reason'] as String?,
      json['status'] as String?,
      json['applyForAllDays'] as bool?,
      json['booked'] as bool?,
      json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      (json['price'] as num?)?.toDouble(),
      json['remove'] as bool?,
    );

Map<String, dynamic> _$PadelScheduleDtoToJson(PadelScheduleDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'padelId': instance.padelId,
      'reason': instance.reason,
      'status': instance.status,
      'booked': instance.booked,
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'applyForAllDays': instance.applyForAllDays,
      'remove': instance.remove,
      'price': instance.price,
    };
