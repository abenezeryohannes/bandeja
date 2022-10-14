import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'payment.freezed.dart';
part 'payment.g.dart';

@freezed
class PaymentModel with _$PaymentModel {
  factory PaymentModel({
    @Default(-1) int id,
    required int userId,
    @Default(0) double amount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _PaymentModel;

  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);
}
