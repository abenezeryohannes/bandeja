// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.response.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationResponseDto _$NotificationResponseDtoFromJson(
        Map<String, dynamic> json) =>
    NotificationResponseDto(
      json['success'] as int?,
      json['failure'] as int?,
    );

Map<String, dynamic> _$NotificationResponseDtoToJson(
        NotificationResponseDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'failure': instance.failure,
    };
