// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
      fullName: json['fullName'] as String,
      avatar: json['avatar'] as String?,
      UID: json['UID'] as String?,
      localImage: json['localImage'] as String?,
      emailAddress: json['emailAddress'] as String?,
      password: json['password'] as String?,
      role: json['role'] as String,
      locationId: json['locationId'] as int?,
      phoneNumber: json['phoneNumber'] as String?,
      enabled: json['enabled'] as bool? ?? true,
    );

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
      'fullName': instance.fullName,
      'avatar': instance.avatar,
      'UID': instance.UID,
      'emailAddress': instance.emailAddress,
      'password': instance.password,
      'role': instance.role,
      'locationId': instance.locationId,
      'phoneNumber': instance.phoneNumber,
      'enabled': instance.enabled,
      'localImage': instance.localImage,
    };
