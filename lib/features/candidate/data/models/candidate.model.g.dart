// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'candidate.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CandidateModel _$CandidateModelFromJson(Map<String, dynamic> json) =>
    CandidateModel(
      name: json['name'] as String,
      image: json['image'] as String,
      categoryId: json['categoryId'] as String,
      featured: json['featured'] as bool? ?? false,
      id: json['id'] as String,
    )
      ..votes = json['votes'] as int
      ..verified = json['verified'] as bool
      ..videoLink = json['videoLink'] as String?
      ..coverImages = (json['coverImages'] as List<dynamic>)
          .map((e) => e as String)
          .toList();

Map<String, dynamic> _$CandidateModelToJson(CandidateModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'categoryId': instance.categoryId,
      'image': instance.image,
      'votes': instance.votes,
      'verified': instance.verified,
      'featured': instance.featured,
      'videoLink': instance.videoLink,
      'coverImages': instance.coverImages,
    };
