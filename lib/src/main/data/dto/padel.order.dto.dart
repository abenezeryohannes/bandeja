import 'package:bandeja/src/core/dto/wrapper.dto.dart';
import 'package:bandeja/src/core/domain/booking/entities/padel.order.dart';
import 'package:json_annotation/json_annotation.dart';

part 'padel.order.dto.g.dart';

@JsonSerializable()
class PadelOrderDto {
  int? id;
  int? padelId;
  int? padelScheduleId;
  String? promoCode;
  int? promoCodeId;
  int? paymentId;
  String? status;
  String? barCode;
  double? amount;
  PadelOrderDto(this.id, this.padelId, this.padelScheduleId, this.promoCode,
      this.promoCodeId, this.barCode, this.amount);

  PadelOrderDto.empty({
    this.id = 0,
    required this.padelId,
    required this.padelScheduleId,
    this.promoCode,
    this.barCode,
    this.paymentId,
    this.amount = 0,
  });
  Map<String, dynamic> toJson() => _$PadelOrderDtoToJson(this);

  factory PadelOrderDto.fromJson(Map<String, dynamic> json) =>
      _$PadelOrderDtoFromJson(json);

  PadelOrderDto.fromModel(PadelOrderModel model) {
    id = model.id;
    padelId = model.padelId;
    padelScheduleId = model.padelScheduleId;
    promoCode = model.PromoCode?.code;
    promoCodeId = model.promoCodeId;
    paymentId = model.paymentId;
    status = model.status;
    barCode = model.barCode;
    amount = model.amount;
  }
}
