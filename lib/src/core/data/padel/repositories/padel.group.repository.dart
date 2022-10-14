import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/network/network.info.dart';
import '../../../domain/padels/entities/padel.group.dart';
import '../../../domain/padels/repositories/i.padel.group.repository.dart';
import '../sources/padel_group/padel.group.local.data.source.dart';
import '../sources/padel_group/padel.group.remote.data.source.dart';

@Singleton(as: IPadelGroupRepository)
class PadelGroupRepository implements IPadelGroupRepository {
  late INetworkInfo networkInfo;
  late PadelGroupLocalDataSource localDataSource;
  late PadelGroupRemoteDataSource remoteDataSource;

  PadelGroupRepository(
      {required this.networkInfo,
      required this.localDataSource,
      required this.remoteDataSource});

  @override
  Future<Either<Failure, PadelGroupModel>?>? getPadelGroup(int id) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.getPadelGroup();
        await localDataSource.savePadelGroup(response);
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
  Future<Either<Failure, List<PadelGroupModel>>?>? getPadelGroups(
      {int? page}) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.getPadelGroups(page);
        if (response == null) return null;
        await localDataSource.savePadelGroups(page, response);
        return Right(response);
      } else {
        final result = await localDataSource.loadPadelGroups(page);
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
  Future<Either<Failure, List<PadelGroupModel>>?>? loadPadelGroups(
      {int? page}) async {
    try {
      final result = await localDataSource.loadPadelGroups(page);
      if (result == null || result == []) throw Failure.noDataFailure();
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure.unExpectedFailure(message: e.toString()));
    }
  }
}
