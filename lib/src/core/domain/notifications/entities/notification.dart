import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'notification.freezed.dart';
part 'notification.g.dart';

@freezed
class NotificationModel with _$NotificationModel {
  factory NotificationModel({
    @Default(-1) int id,
    required int userId,
    @Default("") String title,
    @Default("") String desc,
    @Default(false) bool seen,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
}
