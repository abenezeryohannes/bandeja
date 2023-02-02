import 'package:bandeja/src/core/data/authentication/dto/location.dto.dart';
import 'package:bandeja/src/core/data/authentication/source/auth.local.data.source.dart';
import 'package:bandeja/src/core/data/authentication/source/auth.remote.datasource.dart';
import 'package:bandeja/src/core/domain/authentication/entities/system.variable.dart';
import 'package:dartz/dartz.dart';
import 'package:bandeja/src/core/error/failure.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/authentication/entities/user.dart';
import '../../../domain/authentication/repositories/i.user.repository.dart';
import '../../../network/network.info.dart';
import '../dto/user.dto.dart';

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
      if (response == null) {
        throw UnAuthorizedFailure(message: 'Not logged in yet!');
      }
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
  Future<Either<Failure, UserModel>?>? signupUser(
      {required UserDto user}) async {
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
      {required UserDto user}) async {
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

  @override
  Future<Either<Failure, bool>?>? logoutUser() async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.logOut();
        localDataSource.removeUser();
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
  Future<Either<Failure, UserModel>?>? getUser({required int id}) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.getUser(id: id);
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
  Future<Either<Failure, UserModel>?>? setFCMToken(
      {required String token}) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.setFCMToken(token: token);
        if (response == null) throw ServerFailure();
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
  Future<Either<Failure, bool>?>? onAppVisit({required int padelId}) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.onAppVisit(padelId: padelId);
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
  Future<Either<Failure, bool>?>? onAppVisitEnd({required int padelId}) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.onAppVisitEnd(padelId: padelId);
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
  Future<Either<Failure, bool>?>? updateLocation(
      {required LocationDto locationDto}) async {
    try {
      if (await networkInfo.isConnected) {
        final response =
            await remoteDataSource.editLocation(locationDto: locationDto);
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
  Future<Either<Failure, String?>?>? getSystemVariable(
      {required String key}) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.getSysVar(key: key);
        if (response == null) return Left(UnExpectedFailure());
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
  Future<Either<Failure, SystemVariableModel>?>? setSystemVariable(
      {required String key, required String val}) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.setSysVar(key: key, value: val);
        if (response == null) return Left(UnExpectedFailure());
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
