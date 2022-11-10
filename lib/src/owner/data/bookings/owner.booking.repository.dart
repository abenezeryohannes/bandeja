import 'package:bandeja/src/core/domain/padels/entities/padel.dart';
import 'package:bandeja/src/core/error/failure.dart';
import 'package:bandeja/src/core/domain/booking/entities/padel.order.dart';
import 'package:bandeja/src/core/network/network.info.dart';
import 'package:bandeja/src/main/data/dto/padel.order.dto.dart';
import 'package:bandeja/src/owner/data/bookings/source/owner.booking.local.data.source.dart';
import 'package:bandeja/src/owner/data/bookings/source/owner.booking.remote.data.source.dart';
import 'package:bandeja/src/owner/data/dto/owner.monthly.stat.dto.dart';
import 'package:bandeja/src/owner/data/dto/owner.weekly.stat.dto.dart';
import 'package:bandeja/src/owner/domain/booking/i.owner.booking.repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: IOwnerBookingRepository)
class OwnerBookingRepository implements IOwnerBookingRepository {
  final INetworkInfo networkInfo;
  final OwnerBookingLocalDataSource localDataSource;
  final OwnerBookingRemoteDataSource remoteDataSource;

  OwnerBookingRepository(
      this.networkInfo, this.localDataSource, this.remoteDataSource);

  @override
  Future<Either<Failure, List<PadelOrderModel>>?>? getBookings(
      {int? page,
      int? limit,
      String? search,
      String? startTime,
      String? endTime}) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.getBookings(
            page: page,
            limit: limit,
            search: search,
            startTime: startTime,
            endTime: endTime);
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

  @override
  Future<Either<Failure, List<OwnerWeeklyStatDto>>?>? getOwnerWeeklyStat(
      {String? startTime, String? endTime, PadelModel? padel}) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.getOwnerWeeklyStat(
            startTime: startTime, endTime: endTime, padel: padel);
        if (response == null) return null;
        await localDataSource.saveOwnerWeeklyStat(response);
        return Right(response);
      } else {
        final result = await localDataSource.loadOwnerWeeklyStat();
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
  Future<Either<Failure, OwnerMonthlyStatDto>?>? getOwnerMonthlyStat(
      {String? startTime, String? endTime, PadelModel? padel}) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.getOwnerMontlyStat(
            startTime: startTime, endTime: endTime, padel: padel);
        if (response == null) return null;
        await localDataSource.saveOwnerMontlyStat(response);
        return Right(response);
      } else {
        final result = await localDataSource.loadOwnerMontlyStat();
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
  Future<Either<Failure, PadelOrderModel>?>? getpaymentFromSchedule(
      {required int scheduleId}) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.getpaymentFromSchedule(
            scheduleId: scheduleId);
        if (response == null) throw UnExpectedFailure();
        return Right(response);
      } else {
        throw NetworkFailure();
      }
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure.unExpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PadelOrderModel>?>? getBookingFromQrCode(
      {required String qrCode}) async {
    try {
      if (await networkInfo.isConnected) {
        final response =
            await remoteDataSource.getBookingFromQrCode(qrCode: qrCode);
        if (response == null) throw UnExpectedFailure();
        return Right(response);
      } else {
        throw NetworkFailure();
      }
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure.unExpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PadelOrderModel>?>? editBooking(
      {required PadelOrderDto orderDto}) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.editBooking(orderDto: orderDto);
        if (response == null) throw UnExpectedFailure();
        return Right(response);
      } else {
        throw NetworkFailure();
      }
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure.unExpectedFailure(message: e.toString()));
    }
  }
}
