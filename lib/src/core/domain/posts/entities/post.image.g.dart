// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PostImageModel _$$_PostImageModelFromJson(Map<String, dynamic> json) =>
    _$_PostImageModel(
      id: json['id'] as int? ?? -1,
      postId: json['postId'] as int,
      img: json['img'] as String,
      Post: json['Post'] == null
          ? null
          : PostModel.fromJson(json['Post'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$_PostImageModelToJson(_$_PostImageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'postId': instance.postId,
      'img': instance.img,
      'Post': instance.Post,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
