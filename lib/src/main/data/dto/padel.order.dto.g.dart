// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'padel.order.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PadelOrderDto _$PadelOrderDtoFromJson(Map<String, dynamic> json) =>
    PadelOrderDto(
      json['id'] as int?,
      json['padelId'] as int?,
      json['padelScheduleId'] as int?,
      json['promoCode'] as String?,
      json['promoCodeId'] as int?,
      json['barCode'] as String?,
      (json['amount'] as num?)?.toDouble(),
    )
      ..paymentId = json['paymentId'] as int?
      ..status = json['status'] as String?;

Map<String, dynamic> _$PadelOrderDtoToJson(PadelOrderDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'padelId': instance.padelId,
      'padelScheduleId': instance.padelScheduleId,
      'promoCode': instance.promoCode,
      'promoCodeId': instance.promoCodeId,
      'paymentId': instance.paymentId,
      'status': instance.status,
      'barCode': instance.barCode,
      'amount': instance.amount,
    };
