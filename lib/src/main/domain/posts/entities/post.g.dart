// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PostModel _$$_PostModelFromJson(Map<String, dynamic> json) => _$_PostModel(
      id: json['id'] as int? ?? -1,
      userId: json['userId'] as int,
      title: json['title'] as String? ?? '',
      desc: json['desc'] as String? ?? '',
      whatsApp: json['whatsApp'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      featured: json['featured'] as bool? ?? false,
      postGroupId: json['postGroupId'] as int,
      price: json['price'] as String? ?? '0.0',
      offer: json['offer'] as bool? ?? true,
      enabled: json['enabled'] as bool? ?? true,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      PostGroup: json['PostGroup'] == null
          ? null
          : PostGroupModel.fromJson(json['PostGroup'] as Map<String, dynamic>),
      User: json['User'] == null
          ? null
          : UserModel.fromJson(json['User'] as Map<String, dynamic>),
      PostImages: (json['PostImages'] as List<dynamic>?)
          ?.map((e) => PostImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_PostModelToJson(_$_PostModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'desc': instance.desc,
      'whatsApp': instance.whatsApp,
      'phoneNumber': instance.phoneNumber,
      'featured': instance.featured,
      'postGroupId': instance.postGroupId,
      'price': instance.price,
      'offer': instance.offer,
      'enabled': instance.enabled,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'PostGroup': instance.PostGroup?.toJson(),
      'User': instance.User?.toJson(),
      'PostImages': instance.PostImages?.map((e) => e.toJson()).toList(),
    };
