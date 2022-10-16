// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.image.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostImageDto _$PostImageDtoFromJson(Map<String, dynamic> json) => PostImageDto(
      id: json['id'] ?? -1,
      localImg: json['localImg'] as String?,
      img: json['img'] as String?,
    )..postId = json['postId'] as int?;

Map<String, dynamic> _$PostImageDtoToJson(PostImageDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'postId': instance.postId,
      'img': instance.img,
      'localImg': instance.localImg,
    };
