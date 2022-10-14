// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PostGroupModel _$$_PostGroupModelFromJson(Map<String, dynamic> json) =>
    _$_PostGroupModel(
      id: json['id'] as int? ?? -1,
      name: json['name'] as String? ?? '',
      icon: json['icon'] as String?,
      color: json['color'] as String?,
      enabled: json['enabled'] as bool? ?? true,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$_PostGroupModelToJson(_$_PostGroupModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'color': instance.color,
      'enabled': instance.enabled,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
