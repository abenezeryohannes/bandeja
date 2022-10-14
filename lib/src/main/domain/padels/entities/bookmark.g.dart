// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BookmarkModel _$$_BookmarkModelFromJson(Map<String, dynamic> json) =>
    _$_BookmarkModel(
      id: json['id'] as int? ?? -1,
      userId: json['userId'] as int,
      padelId: json['padelId'] as int,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      Padel: json['Padel'] == null
          ? null
          : PadelModel.fromJson(json['Padel'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_BookmarkModelToJson(_$_BookmarkModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'padelId': instance.padelId,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'Padel': instance.Padel?.toJson(),
    };
