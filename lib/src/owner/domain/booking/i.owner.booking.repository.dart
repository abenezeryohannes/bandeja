import 'package:bandeja/src/core/domain/padels/entities/padel.dart';
import 'package:bandeja/src/main/data/dto/padel.order.dto.dart';
import 'package:bandeja/src/owner/data/dto/owner.monthly.stat.dto.dart';
import 'package:bandeja/src/owner/data/dto/owner.weekly.stat.dto.dart';
import 'package:dartz/dartz.dart';

import '../../../core/domain/booking/entities/padel.order.dart';
import '../../../core/error/failure.dart';

abstract class IOwnerBookingRepository {
  Future<Either<Failure, List<PadelOrderModel>>?>? getBookings(
      {int? page,
      int? limit,
      String? search,
      String? startTime,
      String? endTime});

  Future<Either<Failure, List<OwnerWeeklyStatDto>>?>? getOwnerWeeklyStat(
      {String? startTime, String? endTime, PadelModel? padel});

  Future<Either<Failure, OwnerMonthlyStatDto>?>? getOwnerMonthlyStat(
      {String? startTime, String? endTime, PadelModel? padel});

  Future<Either<Failure, PadelOrderModel>?>? getpaymentFromSchedule(
      {required int scheduleId});

  Future<Either<Failure, PadelOrderModel>?>? editBooking(
      {required PadelOrderDto orderDto});

  Future<Either<Failure, PadelOrderModel>?>? getBookingFromQrCode(
      {required String qrCode});
}
