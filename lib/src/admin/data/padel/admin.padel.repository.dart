import 'package:bandeja/src/admin/data/padel/source/admin.padel.local.data.source.dart';
import 'package:bandeja/src/admin/data/padel/source/admin.padel.remote.data.source.dart';
import 'package:bandeja/src/core/domain/padels/entities/padel.dart';
import 'package:dartz/dartz.dart';
import 'package:bandeja/src/core/error/failure.dart';
import 'package:injectable/injectable.dart';

import '../../../core/network/network.info.dart';
import '../../domain/padel/i.admin.padel.repository.dart';

@Singleton(as: IAdminPadelRepository)
class AdminPadelsRepository implements IAdminPadelRepository {
  INetworkInfo networkInfo;
  AdminPadelRemoteDataSource remoteDataSource;
  AdminPadelLocalDataSource localDataSource;

  AdminPadelsRepository(
      {required this.networkInfo,
      required this.remoteDataSource,
      required this.localDataSource});

  @override
  Future<Either<Failure, List<PadelModel>>?>? getPadels(
      {int? page, int? limit, String? search, bool? enabled}) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.getPadels(
          page: page,
          search: search,
          limit: limit,
          enabled: enabled,
        );
        if (response == null) return const Right([]);
        await localDataSource.savePadels(page, response);
        return Right(response);
      } else {
        final result = await localDataSource.loadPadels(page);
        if (result == null) return throw CacheFailure();
        return Right(result);
      }
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure.unExpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>?>? countAllPadels() async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.countAll();
        if (response == null) return const Right(0);
        return Right(response);
      } else {
        final result = await localDataSource.loadPadels(0);
        return Right(result.length);
      }
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure.unExpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PadelModel>>?>? getPadelsForApproval(
      {int? page, int? limit, String? search, bool? approved}) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.getPadelsForApproval(
          page: page,
          search: search,
          limit: limit,
          approved: approved,
        );
        if (response == null) return const Right([]);
        await localDataSource.savePadels(page, response);
        return Right(response);
      } else {
        final result = await localDataSource.loadPadels(page);
        if (result == null) return throw CacheFailure();
        return Right(result);
      }
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure.unExpectedFailure(message: e.toString()));
    }
  }
}
