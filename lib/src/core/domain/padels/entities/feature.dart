import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'padel.feature.dart';

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
    PadelFeatureModel? PadelFeature,
  }) = _InstrumentModel;

  factory FeatureModel.fromJson(Map<String, dynamic> json) =>
      _$FeatureModelFromJson(json);
}

extension FeatureModelX on FeatureModel {
  PadelFeatureModel getPadelFeature() {
    return PadelFeature ?? PadelFeatureModel(padelId: -1, featureId: id);
  }
}
