import 'package:freezed_annotation/freezed_annotation.dart';

import 'padel.dart';

part 'padel.group.freezed.dart';
part 'padel.group.g.dart';

@freezed
class PadelGroupModel with _$PadelGroupModel {
  factory PadelGroupModel({
    @Default(-1) int id,
    @Default('') String name,
    @Default('') String icon,
    String? color,
    @Default(1) int sequence,
    @Default(true) bool enabled,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<PadelModel>? Padels,
  }) = _PadelGroupModel;
  factory PadelGroupModel.fromJson(Map<String, dynamic> json) =>
      _$PadelGroupModelFromJson(json);
}
