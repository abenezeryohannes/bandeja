// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'padel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Padel _$$_PadelFromJson(Map<String, dynamic> json) => _$_Padel(
      id: json['id'] as int? ?? -1,
      userId: json['userId'] as int,
      durationId: json['durationId'] as int,
      padelGroupId: json['padelGroupId'] as int,
      name: json['name'] as String? ?? '',
      banner: json['banner'] as String? ?? 'placeholder.jpg',
      avatar: json['avatar'] as String? ?? 'placeholder.jpg',
      locationId: json['locationId'] as int?,
      addressId: json['addressId'] as int?,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      price: json['price'] as String? ?? '0.0',
      indoor: json['indoor'] as bool? ?? false,
      onlyLadies: json['onlyLadies'] as bool? ?? false,
      enabled: json['enabled'] as bool? ?? true,
      PadelGroup: json['PadelGroup'] == null
          ? null
          : PadelGroupModel.fromJson(
              json['PadelGroup'] as Map<String, dynamic>),
      Features: (json['Features'] as List<dynamic>?)
          ?.map((e) => FeatureModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      Location: json['Location'] == null
          ? null
          : LocationModel.fromJson(json['Location'] as Map<String, dynamic>),
      Duration: json['Duration'] == null
          ? null
          : DurationModel.fromJson(json['Duration'] as Map<String, dynamic>),
      Address: json['Address'] == null
          ? null
          : AddressModel.fromJson(json['Address'] as Map<String, dynamic>),
      Bookmarks: (json['Bookmarks'] as List<dynamic>?)
          ?.map((e) => BookmarkModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      User: json['User'] == null
          ? null
          : UserModel.fromJson(json['User'] as Map<String, dynamic>),
      PadelSchedules: (json['PadelSchedules'] as List<dynamic>?)
          ?.map((e) => PadelScheduleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$_PadelToJson(_$_Padel instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'durationId': instance.durationId,
      'padelGroupId': instance.padelGroupId,
      'name': instance.name,
      'banner': instance.banner,
      'avatar': instance.avatar,
      'locationId': instance.locationId,
      'addressId': instance.addressId,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'price': instance.price,
      'indoor': instance.indoor,
      'onlyLadies': instance.onlyLadies,
      'enabled': instance.enabled,
      'PadelGroup': instance.PadelGroup,
      'Features': instance.Features,
      'Location': instance.Location,
      'Duration': instance.Duration,
      'Address': instance.Address,
      'Bookmarks': instance.Bookmarks,
      'User': instance.User,
      'PadelSchedules': instance.PadelSchedules,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
