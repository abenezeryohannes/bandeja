import 'package:dartz/dartz.dart';

import '../../../core/domain/booking/entities/padel.order.dart';
import '../../../core/domain/padels/entities/padel.dart';
import '../../../core/error/failure.dart';
import '../../data/booking/dto/admin.monthly.stat.dto.dart';
import '../../data/booking/dto/admin.weekly.stat.dto.dart';

abstract class IAdminBookingRepository {
  Future<Either<Failure, List<PadelOrderModel>>?>? getBookings(
      {int? page, int? limit, String? search, PadelModel? padel});

  Future<Either<Failure, List<AdminWeeklyStatDto>>?>? getAdminWeeklyStat(
      {String? startTime, String? endTime, PadelModel? padel});

  Future<Either<Failure, AdminMonthlyStatDto>?>? getAdminMonthlyStat(
      {String? startTime, String? endTime, PadelModel? padel});
}
