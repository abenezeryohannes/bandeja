import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter/foundation.dart';
part 'location.freezed.dart';
part 'location.g.dart';

@freezed
class LocationModel with _$LocationModel {
  factory LocationModel({
    @Default(-1) int id,
    @Default('0') String latitude,
    @Default('0') String longitude,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _LocationModel;
  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);
}
