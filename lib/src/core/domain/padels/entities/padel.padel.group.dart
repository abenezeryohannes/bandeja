import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'padel.padel.group.freezed.dart';
part 'padel.padel.group.g.dart';

@freezed
class PadelPadelGroupModel with _$PadelPadelGroupModel {
  factory PadelPadelGroupModel({
    @Default(-1) int id,
    int? padelGroupId,
    int? padelId,
    // PadelModel? Padel,
    // PadelGroupModel? PadelGroup,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _PadelPadelGroup;
  factory PadelPadelGroupModel.fromJson(Map<String, dynamic> json) =>
      _$PadelPadelGroupModelFromJson(json);
}

extension PadelPadelGroupModelX on PadelPadelGroupModel {
  // PadelModel getPadel() {
  //   return Padel ??
  //       PadelModel(
  //           name: "Unknown",
  //           durationId: -1,
  //           endTime: DateTime.now(),
  //           startTime: DateTime.now(),
  //           userId: -1);
  // }

  // PadelGroupModel getPadelGroup() {
  //   return PadelGroup ??
  //       PadelGroupModel(
  //         name: "All",
  //       );
  // }
}
