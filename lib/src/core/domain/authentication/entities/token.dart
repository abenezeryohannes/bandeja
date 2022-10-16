import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'token.freezed.dart';
part 'token.g.dart';

@freezed
class TokenModel with _$TokenModel {
  factory TokenModel({
    @Default(-1) int id,
    required int userId,
    @Default("token") String token,
    DateTime? validUntil,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _TokenModel;
  factory TokenModel.fromJson(Map<String, dynamic> json) =>
      _$TokenModelFromJson(json);
}
