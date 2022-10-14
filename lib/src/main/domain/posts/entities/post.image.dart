import 'package:feekpadel/src/main/domain/posts/entities/post.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'post.image.freezed.dart';
part 'post.image.g.dart';

@freezed
class PostImageModel with _$PostImageModel {
  factory PostImageModel({
    @Default(-1) int id,
    required int postId,
    required String img,
    PostModel? Post,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _PostImageModel;

  factory PostImageModel.fromJson(Map<String, dynamic> json) =>
      _$PostImageModelFromJson(json);
}