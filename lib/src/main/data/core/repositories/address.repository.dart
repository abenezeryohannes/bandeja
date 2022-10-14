import 'package:feekpadel/src/main/domain/core/entities/address.dart';

import 'package:feekpadel/src/core/error/failure.dart';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/network/network.info.dart';
import '../../../domain/core/repositories/i.address.repository.dart';
import '../source/address.local.data.source.dart';
import '../source/address.remote.data.source.dart';

@Singleton(as: IAddressRepository)
class AddressRepository implements IAddressRepository {
  late INetworkInfo networkInfo;
  late AddressRemoteDataSource remoteDataSource;
  late AddressLocalDataSource localDataSource;

  AddressRepository(
      {required this.networkInfo,
      required this.remoteDataSource,
      required this.localDataSource});

  get limit => null;
  @override
  Future<Either<Failure, AddressModel>?>? getAddress(int id) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.getAddress(id: id);
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
  Future<Either<Failure, List<AddressModel>>?>? getAddresses(
      {int? page, int? limit}) async {
    try {
      if (await networkInfo.isConnected) {
        final response =
            await remoteDataSource.getAddresses(page: page, limit: limit);
        if (response == null) return null;
        await localDataSource.saveAddresses(page, response);
        return Right(response);
      } else {
        final result = await localDataSource.loadAddresses(page);
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
