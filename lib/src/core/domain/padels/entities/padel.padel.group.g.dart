// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'padel.padel.group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PadelPadelGroup _$$_PadelPadelGroupFromJson(Map<String, dynamic> json) =>
    _$_PadelPadelGroup(
      id: json['id'] as int? ?? -1,
      padelGroupId: json['padelGroupId'] as int?,
      padelId: json['padelId'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$_PadelPadelGroupToJson(_$_PadelPadelGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'padelGroupId': instance.padelGroupId,
      'padelId': instance.padelId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
