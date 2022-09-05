// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String,
      uid: json['uid'] as String?,
      createdAt: json['createdAt'] as String,
      votedFor: json['votedFor'] as String?,
      identifier: json['identifier'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'identifier': instance.identifier,
      'votedFor': instance.votedFor,
      'createdAt': instance.createdAt,
    };
