import 'package:bandeja/src/core/domain/padels/entities/promo.code.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/domain/authentication/entities/user.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network.info.dart';
import '../../../../core/domain/padels/entities/padel.dart';
import '../../../../core/domain/padels/entities/padel.group.dart';
import '../../../domain/core/entities/address.dart';
import '../../../domain/core/entities/location.dart';
import '../../../domain/padels/repositories/i.padel.repository.dart';
import '../sources/padel/padel.local.data.source.dart';
import '../sources/padel/padel.remote.data.source.dart';

@Singleton(as: IPadelRepository)
class PadelRepository implements IPadelRepository {
  late INetworkInfo networkInfo;
  late PadelRemoteDataSource remoteDataSource;
  late PadelLocalDataSource localDataSource;

  PadelRepository(
      {required this.networkInfo,
      required this.remoteDataSource,
      required this.localDataSource});

  @override
  Future<Either<Failure, List<PadelModel>>?>? getFeaturedPadels(
      {int? page,
      AddressModel? address,
      LocationModel? location,
      PadelGroupModel? padelGroup}) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.getFeaturedPadels(
            page, address, location, padelGroup);
        if (response == null) return null;
        await localDataSource.saveFeaturedPadels(page, padelGroup, response);
        return Right(response);
      } else {
        final result = await localDataSource.loadFeaturedPadels(page, address);
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
  Future<Either<Failure, PadelModel>?>? getPadel(int id) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.getPadel(id);
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
  Future<Either<Failure, List<PadelModel>>?>? loadFeaturedPadels(
      {int? page, AddressModel? address}) async {
    try {
      final result = await localDataSource.loadFeaturedPadels(page, address);
      if (result == null) return null;
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure.unExpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PadelModel>>?>? getBookmarks(
      {int? page, int? limit, UserModel? user}) async {
    try {
      if (await networkInfo.isConnected) {
        final response =
            await remoteDataSource.getBookmarks(page: page, limit: limit);
        if (response == null) return const Right([]);
        await localDataSource.saveBookmarks(page, response);
        return Right(response);
      } else {
        final result = await localDataSource.loadBookmarks(page);
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
  Future<Either<Failure, List<UserModel>>?>? getFilterPadels(
      {int? page,
      PadelGroupModel? padelGroup,
      int? limit,
      bool indoor = false,
      AddressModel? address,
      required String date,
      DateTime? timeOfDay}) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.getFilterPadels(
            page: page,
            padelGroup: padelGroup,
            address: address,
            date: date,
            indoor: indoor,
            limit: limit,
            timeOfDay: timeOfDay);
        if (response == null) throw Failure.serverFailure();
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
  Future<Either<Failure, bool>?>? setBookmark({required int padelId}) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.setBookmark(padelId: padelId);
        if (response == null) throw Failure.serverFailure();
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
  Future<Either<Failure, PromoCodeModel>?>? checkPromo(
      {required String promo, required int padelId}) async {
    try {
      final result =
          await remoteDataSource.checkPromo(promo: promo, padelId: padelId);
      if (result == null) throw ServerFailure();
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure.unExpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PadelModel>?>? findPadel(
      {required int padelId, DateTime? date}) async {
    try {
      if (await networkInfo.isConnected) {
        final response =
            await remoteDataSource.findPadel(padelId: padelId, date: date);
        if (response == null) throw Failure.serverFailure();
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
  Future<Either<Failure, PadelModel>?>? findPadelWithPeriod(
      {required int padelId,
      required DateTime startTime,
      required DateTime endTime}) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.findPadelWIthPeriod(
            padelId: padelId, startTime: startTime, endTime: endTime);
        if (response == null) throw Failure.serverFailure();
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
  Future<Either<Failure, bool>?>? isBookmark({required int padelId}) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.isBookmark(padelId: padelId);
        if (response == null) throw Failure.serverFailure();
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
