// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostDto _$PostDtoFromJson(Map<String, dynamic> json) => PostDto(
      enabled: json['enabled'] ?? true,
      offer: json['offer'] ?? false,
      price: json['price'] ?? '0.00',
      featured: json['featured'] ?? false,
      id: json['id'] ?? -1,
    )
      ..userId = json['userId'] as int?
      ..title = json['title'] as String?
      ..desc = json['desc'] as String
      ..whatsApp = json['whatsApp'] as String?
      ..phoneNumber = json['phoneNumber'] as String?
      ..postGroupId = json['postGroupId'] as int?;

Map<String, dynamic> _$PostDtoToJson(PostDto instance) => <String, dynamic>{
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
    };
