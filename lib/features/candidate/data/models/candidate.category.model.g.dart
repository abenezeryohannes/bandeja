// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'candidate.category.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CandidateCategoryModel _$CandidateCategoryModelFromJson(
        Map<String, dynamic> json) =>
    CandidateCategoryModel(
      name: json['name'] as String,
      id: json['id'] as String,
      banners: (json['banners'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      number: json['number'] as String,
    );

Map<String, dynamic> _$CandidateCategoryModelToJson(
        CandidateCategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'name': instance.name,
      'banners': instance.banners,
    };
