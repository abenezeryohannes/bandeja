// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'padel.feature.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PadelFeatureDto _$PadelFeatureDtoFromJson(Map<String, dynamic> json) =>
    PadelFeatureDto(
      json['id'] as int,
      json['featureId'] as int,
      json['padelId'] as int,
      json['free'] as bool,
    );

Map<String, dynamic> _$PadelFeatureDtoToJson(PadelFeatureDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'padelId': instance.padelId,
      'featureId': instance.featureId,
      'free': instance.free,
    };
