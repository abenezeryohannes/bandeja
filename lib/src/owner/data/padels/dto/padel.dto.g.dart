// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'padel.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PadelDto _$PadelDtoFromJson(Map<String, dynamic> json) => PadelDto(
      json['id'] as int,
      json['userId'] as int,
      json['durationId'] as int?,
      json['padelGroupId'] as int?,
      json['name'] as String?,
      json['banner'] as String?,
      json['bannerLocalImage'] as String?,
      json['avatar'] as String?,
      json['avatarLocalImage'] as String?,
      json['approved'] as bool?,
      json['locationId'] as int?,
      json['addressId'] as int?,
      json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      (json['price'] as num).toDouble(),
      json['indoor'] as bool,
      json['onlyLadies'] as bool,
      json['enabled'] as bool,
      (json['padelFeatureDto'] as List<dynamic>)
          .map((e) => PadelFeatureDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['locationDto'] == null
          ? null
          : LocationDto.fromJson(json['locationDto'] as Map<String, dynamic>),
      (json['padelSchedules'] as List<dynamic>)
          .map((e) => PadelScheduleDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PadelDtoToJson(PadelDto instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'durationId': instance.durationId,
      'padelGroupId': instance.padelGroupId,
      'name': instance.name,
      'banner': instance.banner,
      'bannerLocalImage': instance.bannerLocalImage,
      'avatar': instance.avatar,
      'avatarLocalImage': instance.avatarLocalImage,
      'locationId': instance.locationId,
      'addressId': instance.addressId,
      'approved': instance.approved,
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'price': instance.price,
      'indoor': instance.indoor,
      'onlyLadies': instance.onlyLadies,
      'enabled': instance.enabled,
      'locationDto': instance.locationDto,
      'padelFeatureDto': instance.padelFeatureDto,
      'padelSchedules': instance.padelSchedules,
    };
