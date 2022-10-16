import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'post.group.freezed.dart';
part 'post.group.g.dart';

@freezed
class PostGroupModel with _$PostGroupModel {
  factory PostGroupModel({
    @Default(-1) int id,
    @Default('') String name,
    String? icon,
    String? color,
    @Default(true) bool enabled,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _PostGroupModel;

  factory PostGroupModel.fromJson(Map<String, dynamic> json) =>
      _$PostGroupModelFromJson(json);
}

extension PostGroupModelX on PostGroupModel {
  PostGroupModel all() {
    return PostGroupModel(name: 'All', icon: 'all_post_group.png');
  }
}
