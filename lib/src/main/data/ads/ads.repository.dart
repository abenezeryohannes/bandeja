import 'package:bandeja/src/core/domain/ads/entities/ad.dart';
import 'package:bandeja/src/core/error/failure.dart';
import 'package:bandeja/src/core/network/network.info.dart';
import 'package:bandeja/src/main/data/ads/source/ads.local.data.source.dart';
import 'package:bandeja/src/main/data/ads/source/ads.local.remote.source.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/ads/i.ads.repository.dart';

@Singleton(as: IAdRepository)
class AdRepository extends IAdRepository {
  final INetworkInfo networkInfo;
  final AdLocalDataSource localDataSource;
  final AdRemoteDataSource remoteDataSource;

  AdRepository(
      {required this.networkInfo,
      required this.localDataSource,
      required this.remoteDataSource});

  @override
  Future<Either<Failure, List<AdModel>>?>? getAds(
      {int? page, int? limit}) async {
    try {
      if (await networkInfo.isConnected) {
        final response =
            await remoteDataSource.getAds(page: page, limit: limit);
        if (response == null) return null;
        await localDataSource.saveAds(page, response);
        return Right(response);
      } else {
        final result = await localDataSource.loadAds(page);
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
