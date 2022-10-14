// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'padel.price.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PadelPriceModel _$$_PadelPriceModelFromJson(Map<String, dynamic> json) =>
    _$_PadelPriceModel(
      id: json['id'] ?? -1,
      padelId: json['padelId'] as int,
      price: (json['price'] as num?)?.toDouble() ?? 0,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$_PadelPriceModelToJson(_$_PadelPriceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'padelId': instance.padelId,
      'price': instance.price,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
