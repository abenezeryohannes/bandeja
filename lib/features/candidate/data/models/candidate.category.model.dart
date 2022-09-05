import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/candidate.category.dart';
part 'candidate.category.model.g.dart';

@JsonSerializable()
class CandidateCategoryModel extends CandidateCategory {
  CandidateCategoryModel(
      {required super.name,
      required super.id,
      super.banners,
      required super.number});

  factory CandidateCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CandidateCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CandidateCategoryModelToJson(this);
}
