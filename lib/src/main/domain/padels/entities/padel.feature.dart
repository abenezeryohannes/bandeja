import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'padel.feature.freezed.dart';
part 'padel.feature.g.dart';

@freezed
class PadelFeatureModel with _$PadelFeatureModel {
  factory PadelFeatureModel({
    @Default(-1) int id,
    required int padelId,
    required int featureId,
    @Default(true) bool free,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _PadelFeatureModel;

  factory PadelFeatureModel.fromJson(Map<String, dynamic> json) =>
      _$PadelFeatureModelFromJson(json);
}
