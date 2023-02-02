// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ad.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AdModel _$$_AdModelFromJson(Map<String, dynamic> json) => _$_AdModel(
      id: json['id'] as int? ?? -1,
      userId: json['userId'] as int? ?? -1,
      banner: json['banner'] as String,
      link: json['link'] as String? ?? '',
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      User: json['User'] == null
          ? null
          : UserModel.fromJson(json['User'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_AdModelToJson(_$_AdModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'banner': instance.banner,
      'link': instance.link,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'User': instance.User,
    };
