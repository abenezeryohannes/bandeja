// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promo.code.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromoCodeDto _$PromoCodeDtoFromJson(Map<String, dynamic> json) => PromoCodeDto(
      json['code'] as String?,
      json['padelId'] as int?,
      json['maxBooking'] as int,
      (json['discount'] as num?)?.toDouble(),
      json['leftForBooking'] as int?,
    )..id = json['id'] as int?;

Map<String, dynamic> _$PromoCodeDtoToJson(PromoCodeDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'padelId': instance.padelId,
      'maxBooking': instance.maxBooking,
      'discount': instance.discount,
      'leftForBooking': instance.leftForBooking,
    };
