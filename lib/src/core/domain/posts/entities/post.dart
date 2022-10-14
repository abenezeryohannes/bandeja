import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/domain/authentication/entities/user.dart';
import 'post.group.dart';
import 'post.image.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class PostModel with _$PostModel {
  factory PostModel({
    @Default(-1) int id,
    required int userId,
    @Default('') String title,
    @Default('') String desc,
    String? whatsApp,
    String? phoneNumber,
    @Default(false) bool featured,
    required int postGroupId,
    @Default('0.0') String price,
    @Default(true) bool offer,
    @Default(true) bool enabled,
    DateTime? createdAt,
    DateTime? updatedAt,
    PostGroupModel? PostGroup,
    UserModel? User,
    List<PostImageModel>? PostImages,
  }) = _PostModel;

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
}

extension PostModelX on PostModel {
  String coverImage() {
    if (PostImages == null || PostImages!.isEmpty) return 'placeholder.png';
    return PostImages![0].img;
  }

  List<String> coverImages() {
    if (PostImages == null || PostImages!.isEmpty) return ['placeholder.png'];
    return PostImages!.map((e) => e.img).toList();
  }

  PostGroupModel getGroup() {
    return PostGroup ?? PostGroupModel(name: "-");
  }
}
