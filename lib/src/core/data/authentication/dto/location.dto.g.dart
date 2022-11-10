// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationDto _$LocationDtoFromJson(Map<String, dynamic> json) => LocationDto(
      json['id'] as int?,
      (json['latitude'] as num?)?.toDouble(),
      (json['longitude'] as num?)?.toDouble(),
      json['address'] as String?,
    );

Map<String, dynamic> _$LocationDtoToJson(LocationDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
    };
