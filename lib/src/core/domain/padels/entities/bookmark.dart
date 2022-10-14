import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'padel.dart';

part 'bookmark.freezed.dart';
part 'bookmark.g.dart';

@freezed
class BookmarkModel with _$BookmarkModel {
  factory BookmarkModel({
    @Default(-1) int id,
    required int userId,
    required int padelId,
    DateTime? createdAt,
    DateTime? updatedAt,
    PadelModel? Padel,
  }) = _BookmarkModel;
  factory BookmarkModel.fromJson(Map<String, dynamic> json) =>
      _$BookmarkModelFromJson(json);
}
