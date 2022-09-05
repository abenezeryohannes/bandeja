import 'package:app/features/setting/domain/entities/setting.dart';
import 'package:app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:app/features/setting/domain/repositories/setting.repository.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network.info.dart';
import '../datasources/setting.local.data.source copy.dart';
import '../datasources/setting.remote.data.source.dart';

class SettingRepositoryImp implements SettingRepository {
  late NetworkInfo networkInfo;
  late SettingLocalDataSource localDataSource;
  late SettingRemoteDataSource remoteDataSource;

  SettingRepositoryImp(
      {required this.networkInfo,
      required this.localDataSource,
      required this.remoteDataSource});

  @override
  Future<Either<Failure, Setting>>? getSetting() async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.getSetting();
        if (result == null) throw NoDataException();
        localDataSource.addSettingToCache(result);
        return Right(result);
      } else {
        final result = await localDataSource.loadSetting();
        if (result == null) throw NoDataException();
        return Right(result);
      }
    } on ServerSideException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on NoDataException catch (e) {
      return Left(NoDataFailure(message: e.message));
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, Setting>>? loadSetting() async {
    try {
      final result = await localDataSource.loadSetting();
      if (result == null) return throw NoDataException();
      return Right(result);
    } on ServerSideException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on NoDataException catch (e) {
      return Left(NoDataFailure(message: e.message));
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, Setting>>? setSetting(Setting setting) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.getSetting();
        if (result == null) return throw NoDataException();
        localDataSource.addSettingToCache(result);
        return Right(result);
      } else {
        final result = await localDataSource.loadSetting();
        if (result == null) return throw NoDataException();
        return Right(result);
      }
    } on ServerSideException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on NoDataException catch (e) {
      return Left(NoDataFailure(message: e.message));
    } catch (e) {
      return Left(Failure());
    }
  }
}
