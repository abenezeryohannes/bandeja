import 'package:feekpadel/src/main/domain/booking/entities/payment.dart';
import 'package:feekpadel/src/main/domain/padels/entities/padel.schedule.dart';
import 'package:feekpadel/src/main/domain/padels/entities/promo.code.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../../authentication/entities/user.dart';
import '../../padels/entities/padel.dart';

part 'padel.order.freezed.dart';
part 'padel.order.g.dart';

@freezed
class PadelOrderModel with _$PadelOrderModel {
  factory PadelOrderModel({
    @Default(-1) int id,
    required int userId,
    required int padelId,
    required int padelScheduleId,
    int? promoCodeId,
    int? paymentId,
    String? barCode,
    @Default('pending') String status,
    @Default(true) bool enabled,
    DateTime? createdAt,
    DateTime? updatedAt,
    UserModel? User,
    PaymentModel? Payment,
    PromoCodeModel? PromoCode,
    PadelModel? Padel,
    PadelScheduleModel? PadelSchedule,
  }) = _PadelOrderModel;

  factory PadelOrderModel.fromJson(Map<String, dynamic> json) =>
      _$PadelOrderModelFromJson(json);
}

extension PadelOrderModelX on PadelOrderModel {
  PadelScheduleModel getSchedule() {
    return this.PadelSchedule ??
        PadelScheduleModel(
            endTime: DateTime.now(), padelId: 1, startTime: DateTime.now());
  }
}
