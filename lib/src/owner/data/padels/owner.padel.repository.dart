import 'package:bandeja/src/core/domain/padels/entities/feature.dart';
import 'package:bandeja/src/core/domain/padels/entities/duration.dart';
import 'package:bandeja/src/core/domain/padels/entities/padel.schedule.dart';
import 'package:bandeja/src/core/error/failure.dart';
import 'package:bandeja/src/core/domain/padels/entities/promo.code.dart';
import 'package:bandeja/src/core/domain/padels/entities/padel.dart';
import 'package:bandeja/src/core/domain/booking/entities/padel.order.dart';
import 'package:bandeja/src/core/network/network.info.dart';
import 'package:bandeja/src/owner/data/bookings/dto/padel.schedule.dto.dart';
import 'package:bandeja/src/owner/data/padels/dto/padel.dto.dart';
import 'package:bandeja/src/owner/data/padels/source/owner.padel.local.data.source.dart';
import 'package:bandeja/src/owner/data/padels/source/owner.padel.remote.data.source.dart';
import 'package:bandeja/src/owner/domain/padels/i.owner.padel.repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'dto/promo.code.dto.dart';

@Singleton(as: IOwnerPadelRepository)
class OwnerPadelRepository implements IOwnerPadelRepository {
  final OwnerPadelLocalDataSource localDataSource;
  final OwnerPadelRemoteDataSource remoteDataSource;
  final INetworkInfo networkInfo;

  OwnerPadelRepository(
      this.localDataSource, this.remoteDataSource, this.networkInfo);

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
  Future<Either<Failure, List<PadelModel>>?>? getPadels(
      {int? page, int? limit, String? startTime, String? endTime}) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.getPadels(
            page: page, limit: limit, startTime: startTime, endTime: endTime);
        if (response == null) return null;
        await localDataSource.savePadels(page, response);
        return Right(response);
      } else {
        final result = await localDataSource.loadPadels(page);
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
  Future<Either<Failure, List<PromoCodeModel>>?>? getPromoCodes(
      {int? page, int? limit}) async {
    try {
      if (await networkInfo.isConnected) {
        final response =
            await remoteDataSource.getPromoCodes(page: page, limit: limit);
        await localDataSource.savePromoCodes(page, response);
        return Right(response);
      } else {
        final result = await localDataSource.loadPromoCodes(page);
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
  Future<Either<Failure, PromoCodeModel>?>? addPromoCode(
      {required PromoCodeDto promo}) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.addPromoCode(promo: promo);
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
  Future<Either<Failure, PadelScheduleModel>?>? editPadelSchedule(
      {required PadelScheduleDto schedule}) async {
    try {
      if (await networkInfo.isConnected) {
        final response =
            await remoteDataSource.editSchedule(schedule: schedule);
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
  Future<Either<Failure, List<DurationModel>>?>? getDurations(
      {int? page, int? limit}) async {
    try {
      if (await networkInfo.isConnected) {
        final response =
            await remoteDataSource.getDurations(page: page, limit: limit);
        await localDataSource.saveDurations(page, response);
        return Right(response);
      } else {
        final result = await localDataSource.loadPromoCodes(page);
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
  Future<Either<Failure, List<FeatureModel>>?>? getFeatures(
      {int? page, int? limit}) async {
    try {
      if (await networkInfo.isConnected) {
        final response =
            await remoteDataSource.getFeatures(page: page, limit: limit);
        await localDataSource.saveFeatures(page, response);
        return Right(response);
      } else {
        final result = await localDataSource.loadFeatures(page);
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
  Future<Either<Failure, PadelModel>?>? addPadel(
      {required PadelDto padelDto}) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.addPadel(padelDto: padelDto);
        if (response == null) return null;
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
  Future<Either<Failure, PadelModel>?>? editPadel(
      {required PadelDto padelDto}) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.editPadel(padelDto: padelDto);
        if (response == null) return null;
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
  Future<Either<Failure, PromoCodeModel>?>? editPromoCode(
      {required PromoCodeDto promo}) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.editPromoCode(promo: promo);
        if (response == null) return throw UnExpectedFailure();
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
