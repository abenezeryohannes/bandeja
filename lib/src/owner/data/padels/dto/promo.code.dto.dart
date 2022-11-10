import 'package:bandeja/src/core/domain/padels/entities/promo.code.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'promo.code.dto.g.dart';

@JsonSerializable()
class PromoCodeDto {
  int? id;
  String? code;
  int? padelId;
  int maxBooking = 20;
  double? discount;
  int? leftForBooking;

  PromoCodeDto(this.code, this.padelId, this.maxBooking, this.discount,
      this.leftForBooking);

  PromoCodeDto.EmptyPromoCodeDto(
      {this.code,
      this.padelId,
      this.maxBooking = 20,
      this.discount,
      this.leftForBooking});

  Map<String, dynamic> toJson() => _$PromoCodeDtoToJson(this);

  factory PromoCodeDto.fromJson(Map<String, dynamic> json) =>
      _$PromoCodeDtoFromJson(json);

  PromoCodeDto.fromModel(PromoCodeModel promo) {
    id = promo.id;
    code = promo.code;
    padelId = promo.padelId;
    maxBooking = promo.maxBooking;
    discount = promo.discount;
    leftForBooking = promo.leftForBooking;
  }
}
