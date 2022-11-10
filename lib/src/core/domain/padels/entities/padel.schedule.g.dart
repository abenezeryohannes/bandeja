// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'padel.schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PadelScheduleModel _$$_PadelScheduleModelFromJson(
        Map<String, dynamic> json) =>
    _$_PadelScheduleModel(
      id: json['id'] ?? -1,
      padelId: json['padelId'] as int,
      reason: json['reason'] as String? ?? '',
      status: json['status'] ?? 'free',
      booked: json['booked'] as bool? ?? false,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      price: (json['price'] as num?)?.toDouble(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$_PadelScheduleModelToJson(
        _$_PadelScheduleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'padelId': instance.padelId,
      'reason': instance.reason,
      'status': instance.status,
      'booked': instance.booked,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'price': instance.price,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
