// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'padel.order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PadelOrderModel _$$_PadelOrderModelFromJson(Map<String, dynamic> json) =>
    _$_PadelOrderModel(
      id: json['id'] as int? ?? -1,
      userId: json['userId'] as int,
      padelId: json['padelId'] as int,
      padelScheduleId: json['padelScheduleId'] as int,
      promoCodeId: json['promoCodeId'] as int?,
      paymentId: json['paymentId'] as int?,
      barCode: json['barCode'] as String?,
      status: json['status'] as String? ?? 'pending',
      enabled: json['enabled'] as bool? ?? true,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      User: json['User'] == null
          ? null
          : UserModel.fromJson(json['User'] as Map<String, dynamic>),
      Payment: json['Payment'] == null
          ? null
          : PaymentModel.fromJson(json['Payment'] as Map<String, dynamic>),
      PromoCode: json['PromoCode'] == null
          ? null
          : PromoCodeModel.fromJson(json['PromoCode'] as Map<String, dynamic>),
      Padel: json['Padel'] == null
          ? null
          : PadelModel.fromJson(json['Padel'] as Map<String, dynamic>),
      PadelSchedule: json['PadelSchedule'] == null
          ? null
          : PadelScheduleModel.fromJson(
              json['PadelSchedule'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_PadelOrderModelToJson(_$_PadelOrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'padelId': instance.padelId,
      'padelScheduleId': instance.padelScheduleId,
      'promoCodeId': instance.promoCodeId,
      'paymentId': instance.paymentId,
      'barCode': instance.barCode,
      'status': instance.status,
      'enabled': instance.enabled,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'User': instance.User?.toJson(),
      'Payment': instance.Payment?.toJson(),
      'PromoCode': instance.PromoCode?.toJson(),
      'Padel': instance.Padel?.toJson(),
      'PadelSchedule': instance.PadelSchedule?.toJson(),
    };
