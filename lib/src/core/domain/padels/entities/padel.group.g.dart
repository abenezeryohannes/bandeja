// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'padel.group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PadelGroupModel _$$_PadelGroupModelFromJson(Map<String, dynamic> json) =>
    _$_PadelGroupModel(
      id: json['id'] as int? ?? -1,
      name: json['name'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
      color: json['color'] as String?,
      sequence: json['sequence'] as int? ?? 1,
      enabled: json['enabled'] as bool? ?? true,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      Padels: (json['Padels'] as List<dynamic>?)
          ?.map((e) => PadelModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_PadelGroupModelToJson(_$_PadelGroupModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'color': instance.color,
      'sequence': instance.sequence,
      'enabled': instance.enabled,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'Padels': instance.Padels,
    };
