import 'package:bandeja/src/core/data/authentication/source/auth.local.data.source.dart';
import 'package:bandeja/src/core/data/authentication/source/auth.remote.datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:bandeja/src/core/error/failure.dart';
import 'package:injectable/injectable.dart';

import '../../../core/network/network.info.dart';
import '../../domain/authentication/entities/user.dart';
import '../../domain/authentication/repositories/i.user.repository.dart';
import 'dto/user.dto.dart';

@Singleton(as: IUserRepository)
class UserRepository implements IUserRepository {
  INetworkInfo networkInfo;
  AuthRemoteDataSource remoteDataSource;
  AuthLocalDataSource localDataSource;

  UserRepository(
      {required this.networkInfo,
      required this.remoteDataSource,
      required this.localDataSource});

  @override
  Future<Either<Failure, UserModel>?>? loadUser() async {
    try {
      final response = await localDataSource.loadUser();
      if (response == null) throw CacheFailure(message: 'Not logged in yet!');
      return Right(response);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure.unExpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>?>? editUser({required UserDto user}) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.editUser(userDto: user);
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
  Future<Either<Failure, UserModel>?>? signupUser(
      {required UserModel user}) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.signupUser(user: user);
        localDataSource.saveUser(response);
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
  Future<Either<Failure, UserModel>?>? loginUser(
      {required UserModel user}) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.loginUser(user: user);
        localDataSource.saveUser(response);
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
