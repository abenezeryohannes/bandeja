import 'package:feekpadel/src/main/domain/padels/entities/padel.feature.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'feature.freezed.dart';
part 'feature.g.dart';

@freezed
class FeatureModel with _$FeatureModel {
  factory FeatureModel({
    @Default(-1) int id,
    @Default("") String name,
    @Default("") String icon,
    DateTime? createdAt,
    DateTime? updatedAt,
    PadelFeatureModel? padelFeature,
  }) = _InstrumentModel;

  factory FeatureModel.fromJson(Map<String, dynamic> json) =>
      _$FeatureModelFromJson(json);
}
