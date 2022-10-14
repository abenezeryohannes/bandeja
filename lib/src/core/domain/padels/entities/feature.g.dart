// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_InstrumentModel _$$_InstrumentModelFromJson(Map<String, dynamic> json) =>
    _$_InstrumentModel(
      id: json['id'] as int? ?? -1,
      name: json['name'] as String? ?? "",
      icon: json['icon'] as String? ?? "",
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      PadelFeature: json['PadelFeature'] == null
          ? null
          : PadelFeatureModel.fromJson(
              json['PadelFeature'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_InstrumentModelToJson(_$_InstrumentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'PadelFeature': instance.PadelFeature,
    };
