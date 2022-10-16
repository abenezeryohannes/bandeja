import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../main/domain/core/entities/location.dart';
import '../../padels/entities/bookmark.dart';
import '../../padels/entities/padel.dart';
import 'token.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class UserModel with _$UserModel {
  factory UserModel({
    @Default(-1) int id,
    required String fullName,
    String? avatar,
    String? UID,
    String? emailAddress,
    String? password,
    @Default("user") String role,
    int? locationId,
    @Default("00000000") String phoneNumber,
    @Default(true) bool enabled,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<TokenModel>? Tokens,
    TokenModel? Token,
    LocationModel? Location,
    List<BookmarkModel>? Bookmarks,
    List<PadelModel>? Padels,
  }) = _UserModel;

  factory UserModel.empty() => UserModel(
        id: -1,
        fullName: '',
        phoneNumber: '00000000',
      );

  factory UserModel.fromJson(Map<String, Object?> json) =>
      _$UserModelFromJson(json);
}

extension UserModelX on UserModel {
  List<PadelModel> getPadels() {
    return Padels ?? [];
  }
}
