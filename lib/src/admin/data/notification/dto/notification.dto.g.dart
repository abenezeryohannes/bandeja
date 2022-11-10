// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationDto _$NotificationDtoFromJson(Map<String, dynamic> json) =>
    NotificationDto(
      json['seen'] as bool,
      json['title'] as String,
      json['desc'] as String?,
      json['token'] as String?,
      json['role'] as String?,
      json['userId'] as int?,
    );

Map<String, dynamic> _$NotificationDtoToJson(NotificationDto instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'title': instance.title,
      'desc': instance.desc,
      'token': instance.token,
      'seen': instance.seen,
      'role': instance.role,
    };
