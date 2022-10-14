import 'package:freezed_annotation/freezed_annotation.dart';

part 'setting.freezed.dart';
part 'setting.g.dart';

@freezed
class SettingModel with _$SettingModel {
  factory SettingModel({
    @Default(-1) int id,
    required int userId,
    @Default(true) bool bookingNotification,
    @Default(true) bool faceId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _SettingModel;

  factory SettingModel.fromJson(Map<String, Object?> json) =>
      _$SettingModelFromJson(json);
}
