import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/domain/authentication/entities/user.dart';
import '../../padels/entities/padel.dart';
import '../../padels/entities/padel.schedule.dart';
import '../../padels/entities/promo.code.dart';
import 'payment.dart';

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
    DateTime? paymentDate,
    @Default(0) double amount,
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
  UserModel getUser() {
    return this.User ?? UserModel(fullName: '    ');
  }

  PaymentModel getPayment() {
    return Payment ?? PaymentModel(userId: getUser().id);
  }

  PadelModel getPadel() {
    return Padel ??
        PadelModel(
            userId: -1,
            durationId: -1,
            padelGroupId: -1,
            startTime: DateTime.now(),
            endTime: DateTime.now());
  }

  PadelScheduleModel getSchedule() {
    return PadelSchedule ??
        PadelScheduleModel(
            endTime: DateTime.now(), padelId: 1, startTime: DateTime.now());
  }
}
