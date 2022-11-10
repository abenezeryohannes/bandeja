// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      id: json['id'] as int? ?? -1,
      fullName: json['fullName'] as String? ?? '',
      avatar: json['avatar'] as String?,
      UID: json['UID'] as String?,
      emailAddress: json['emailAddress'] as String?,
      password: json['password'] as String?,
      role: json['role'] as String? ?? "user",
      locationId: json['locationId'] as int?,
      phoneNumber: json['phoneNumber'] as String? ?? "",
      enabled: json['enabled'] as bool? ?? true,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      Tokens: (json['Tokens'] as List<dynamic>?)
          ?.map((e) => TokenModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      Token: json['Token'] == null
          ? null
          : TokenModel.fromJson(json['Token'] as Map<String, dynamic>),
      Setting: json['Setting'] == null
          ? null
          : SettingModel.fromJson(json['Setting'] as Map<String, dynamic>),
      Location: json['Location'] == null
          ? null
          : LocationModel.fromJson(json['Location'] as Map<String, dynamic>),
      Bookmarks: (json['Bookmarks'] as List<dynamic>?)
          ?.map((e) => BookmarkModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      Padels: (json['Padels'] as List<dynamic>?)
          ?.map((e) => PadelModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'avatar': instance.avatar,
      'UID': instance.UID,
      'emailAddress': instance.emailAddress,
      'password': instance.password,
      'role': instance.role,
      'locationId': instance.locationId,
      'phoneNumber': instance.phoneNumber,
      'enabled': instance.enabled,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'Tokens': instance.Tokens,
      'Token': instance.Token,
      'Setting': instance.Setting,
      'Location': instance.Location,
      'Bookmarks': instance.Bookmarks,
      'Padels': instance.Padels,
    };
