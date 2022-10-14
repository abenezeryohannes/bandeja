// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'padel.feature.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PadelFeatureModel _$$_PadelFeatureModelFromJson(Map<String, dynamic> json) =>
    _$_PadelFeatureModel(
      id: json['id'] as int? ?? -1,
      padelId: json['padelId'] as int,
      featureId: json['featureId'] as int,
      free: json['free'] as bool? ?? true,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$_PadelFeatureModelToJson(
        _$_PadelFeatureModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'padelId': instance.padelId,
      'featureId': instance.featureId,
      'free': instance.free,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
