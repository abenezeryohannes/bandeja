import 'package:json_annotation/json_annotation.dart';
import 'package:app/features/candidate/domain/entities/candidate.dart';
part 'candidate.model.g.dart';

@JsonSerializable()
class CandidateModel extends Candidate {
  CandidateModel(
      {required super.name,
      required super.image,
      required super.categoryId,
      super.featured,
      required super.id});

  factory CandidateModel.fromJson(Map<String, dynamic> json) =>
      _$CandidateModelFromJson(json);

  Map<String, dynamic> toJson() => _$CandidateModelToJson(this);
}
