// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promo.code.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PromoCodeModel _$$_PromoCodeModelFromJson(Map<String, dynamic> json) =>
    _$_PromoCodeModel(
      id: json['id'] as int? ?? -1,
      userId: json['userId'] as int?,
      padelId: json['padelId'] as int,
      code: json['code'] as String? ?? '',
      maxBooking: json['maxBooking'] as int? ?? 0,
      leftForBooking: json['leftForBooking'] as int? ?? 0,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$_PromoCodeModelToJson(_$_PromoCodeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'padelId': instance.padelId,
      'code': instance.code,
      'maxBooking': instance.maxBooking,
      'leftForBooking': instance.leftForBooking,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
