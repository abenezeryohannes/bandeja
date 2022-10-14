import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter/foundation.dart';

part 'address.freezed.dart';
part 'address.g.dart';

@freezed
class AddressModel with _$AddressModel {
  factory AddressModel({
    @Default(-1) int id,
    @Default('') String name,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _AddressModel;

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);
}
