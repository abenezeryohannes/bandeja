// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SettingModel _$$_SettingModelFromJson(Map<String, dynamic> json) =>
    _$_SettingModel(
      id: json['id'] as int? ?? -1,
      userId: json['userId'] as int,
      bookingNotification: json['bookingNotification'] as bool? ?? true,
      faceId: json['faceId'] as bool? ?? true,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$_SettingModelToJson(_$_SettingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'bookingNotification': instance.bookingNotification,
      'faceId': instance.faceId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
