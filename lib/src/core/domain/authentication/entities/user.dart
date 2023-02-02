import 'package:bandeja/src/core/data/authentication/dto/user.dto.dart';
import 'package:bandeja/src/core/domain/authentication/entities/setting.dart';
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
    @Default('') String fullName,
    String? avatar,
    String? UID,
    String? emailAddress,
    String? password,
    @Default("user") String role,
    int? locationId,
    @Default("") String phoneNumber,
    @Default(true) bool enabled,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<TokenModel>? Tokens,
    TokenModel? Token,
    SettingModel? Setting,
    LocationModel? Location,
    List<BookmarkModel>? Bookmarks,
    List<PadelModel>? Padels,
  }) = _UserModel;

  factory UserModel.empty() => UserModel(
        id: -1,
        fullName: '',
        phoneNumber: '',
      );

  factory UserModel.fromJson(Map<String, Object?> json) =>
      _$UserModelFromJson(json);
}

extension UserModelX on UserModel {
  List<PadelModel> getPadels() {
    return Padels ?? [];
  }

  UserDto getDTO() {
    return UserDto(
        fullName: fullName,
        role: role,
        avatar: avatar,
        emailAddress: emailAddress,
        faceId: Setting?.faceId ?? false,
        bookingNotification: Setting?.bookingNotification ?? false,
        enabled: enabled);
  }
}
