import 'package:bandeja/src/admin/data/booking/source/admin.booking.local.data.source.dart';
import 'package:bandeja/src/admin/data/booking/source/admin.booking.remote.data.source.dart';
import 'package:dartz/dartz.dart';
import 'package:bandeja/src/core/error/failure.dart';
import 'package:bandeja/src/core/domain/padels/entities/padel.dart';
import 'package:bandeja/src/core/domain/booking/entities/padel.order.dart';
import 'package:injectable/injectable.dart';

import '../../../core/network/network.info.dart';
import '../../domain/booking/i.admin.booking.repository.dart';
import 'dto/admin.monthly.stat.dto.dart';
import 'dto/admin.weekly.stat.dto.dart';

@Singleton(as: IAdminBookingRepository)
class AdminBookingRepository implements IAdminBookingRepository {
  INetworkInfo networkInfo;
  AdminBookingRemoteDataSource remoteDataSource;
  AdminBookingLocalDataSource localDataSource;

  AdminBookingRepository(
      {required this.networkInfo,
      required this.remoteDataSource,
      required this.localDataSource});

  @override
  Future<Either<Failure, AdminMonthlyStatDto>?>? getAdminMonthlyStat(
      {String? startTime, String? endTime, PadelModel? padel}) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.getAdminMonthlyStat(
            startTime: startTime, endTime: endTime, padel: padel);
        if (response == null) return null;
        await localDataSource.saveAdminMonthlyStat(response);
        return Right(response);
      } else {
        final result = await localDataSource.loadAdminMonthlyStat();
        if (result == null) return null;
        return Right(result);
      }
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure.unExpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AdminWeeklyStatDto>>?>? getAdminWeeklyStat(
      {String? startTime, String? endTime, PadelModel? padel}) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.getAdminWeeklyStat(
            startTime: startTime, endTime: endTime, padel: padel);
        if (response == null) return null;
        await localDataSource.saveAdminWeeklyStat(response);
        return Right(response);
      } else {
        final result = await localDataSource.loadAdminWeeklyStat();
        if (result == null) return null;
        return Right(result);
      }
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure.unExpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PadelOrderModel>>?>? getBookings(
      {int? page, int? limit, String? search, PadelModel? padel}) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.getBookings(
            page: page, limit: limit, search: search, padel: padel);
        if (response == null) return null;
        await localDataSource.saveBookings(page, response);
        return Right(response);
      } else {
        final result = await localDataSource.loadBookings(page);
        if (result == null) return null;
        return Right(result);
      }
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure.unExpectedFailure(message: e.toString()));
    }
  }
}
