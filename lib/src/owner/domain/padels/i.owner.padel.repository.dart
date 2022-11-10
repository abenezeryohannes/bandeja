import 'package:bandeja/src/core/domain/booking/entities/padel.order.dart';
import 'package:bandeja/src/core/domain/padels/entities/duration.dart';
import 'package:bandeja/src/core/domain/padels/entities/feature.dart';
import 'package:bandeja/src/core/domain/padels/entities/padel.schedule.dart';
import 'package:bandeja/src/core/domain/padels/entities/promo.code.dart';
import 'package:bandeja/src/owner/data/bookings/dto/padel.schedule.dto.dart';
import 'package:bandeja/src/owner/data/padels/dto/padel.dto.dart';
import 'package:dartz/dartz.dart';

import '../../../core/domain/padels/entities/padel.dart';
import '../../../core/error/failure.dart';
import '../../data/padels/dto/promo.code.dto.dart';

abstract class IOwnerPadelRepository {
  Future<Either<Failure, List<PromoCodeModel>>?>? getPromoCodes(
      {int? page, int? limit});
  Future<Either<Failure, List<FeatureModel>>?>? getFeatures(
      {int? page, int? limit});
  Future<Either<Failure, List<DurationModel>>?>? getDurations(
      {int? page, int? limit});
  Future<Either<Failure, List<PadelModel>>?>? getPadels(
      {int? page, int? limit, String? startTime, String? endTime});
  Future<Either<Failure, PromoCodeModel>?>? addPromoCode(
      {required PromoCodeDto promo});
  Future<Either<Failure, PromoCodeModel>?>? editPromoCode(
      {required PromoCodeDto promo});
  Future<Either<Failure, PadelModel>?>? addPadel({required PadelDto padelDto});
  Future<Either<Failure, PadelModel>?>? editPadel({required PadelDto padelDto});
  Future<Either<Failure, PadelScheduleModel>?>? editPadelSchedule(
      {required PadelScheduleDto schedule});
  Future<Either<Failure, List<PadelOrderModel>>?>? getBookings(
      {int? page,
      int? limit,
      String? search,
      String? startTime,
      String? endTime});
}
