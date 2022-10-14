import 'package:feekpadel/src/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:feekpadel/src/main/domain/padels/entities/padel.group.dart';
import 'package:feekpadel/src/main/domain/authentication/entities/user.dart';
import 'package:feekpadel/src/main/domain/padels/repositories/i.padel.repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/network.info.dart';
import '../../../domain/core/entities/address.dart';
import '../../../domain/core/entities/location.dart';
import '../../../domain/padels/entities/padel.dart';
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
      {int? page, AddressModel? address, LocationModel? location}) async {
    try {
      if (await networkInfo.isConnected) {
        final response =
            await remoteDataSource.getFeaturedPadels(page, address, location);
        if (response == null) return null;
        await localDataSource.saveFeaturedPadels(page, address, response);
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
        if (response == null) return null;
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
}
