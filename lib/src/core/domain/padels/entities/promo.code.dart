import 'package:freezed_annotation/freezed_annotation.dart';

part 'promo.code.freezed.dart';
part 'promo.code.g.dart';

@freezed
class PromoCodeModel with _$PromoCodeModel {
  factory PromoCodeModel({
    @Default(-1) int id,
    required int? userId,
    required int padelId,
    @Default('') String code,
    @Default(0) int maxBooking,
    @Default(0) int leftForBooking,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _PromoCodeModel;
  factory PromoCodeModel.fromJson(Map<String, dynamic> json) =>
      _$PromoCodeModelFromJson(json);
}
