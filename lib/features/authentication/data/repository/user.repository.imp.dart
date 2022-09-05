import 'package:app/core/network/network.info.dart';
import 'package:app/features/authentication/data/datasource/user.local.data.source.dart';
import 'package:app/features/authentication/data/datasource/user.remote.data.source.dart';
import 'package:app/features/authentication/domain/entities/user.dart';
import 'package:app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:app/features/authentication/domain/repositories/user.repository.dart';
import 'package:app/features/candidate/domain/entities/candidate.dart';

import '../../../../core/error/exceptions.dart';
import '../models/user.model.dart';

class UserRepositoyImp implements UserRepositoy {
  late NetworkInfo networkInfo;
  late UserLocalDataSource localDataSource;
  late UserRemoteDataSource remoteDataSource;

  UserRepositoyImp(
      {required this.networkInfo,
      required this.localDataSource,
      required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> getUser(String uid) async {
    try {
      if (await networkInfo.isConnected) {
        final result = await remoteDataSource.getUser(uid);
        if (result == null) throw NoDataException();
        localDataSource.addUserToCache(result);
        return Right(result);
      } else {
        final result = await localDataSource.loadUser();
        if (result == null) throw NoDataException();
        return Right(result);
      }
    } on ServerSideException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on NoDataException catch (e) {
      return Left(NoDataFailure(message: e.message));
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, User>> setUser(User user) async {
    try {
      if (await networkInfo.isConnected) {
        UserModel userModel = UserModel(
            id: user.id,
            createdAt: user.createdAt,
            identifier: user.identifier,
            votedFor: user.votedFor,
            uid: user.uid);
        User? newUser = await remoteDataSource.saveUser(userModel);
        if (newUser == null) {
          throw ServerSideException();
        } else {
          UserModel newUserModel = UserModel(
              id: newUser.id,
              createdAt: newUser.createdAt,
              identifier: newUser.identifier,
              votedFor: newUser.votedFor,
              uid: newUser.uid);
          bool? result = await localDataSource.addUserToCache(newUserModel);

          // print("result $result user: ${newUserModel.toString()}");
        }
        return Right(user);
      } else {
        throw NetworkException();
      }
    } on ServerSideException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on NoDataException catch (e) {
      return Left(NoDataFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NoDataFailure(message: e.message));
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, User>> loadUser() async {
    try {
      final result = await localDataSource.loadUser();
      if (result == null) throw NoDataException();
      return Right(result);
    } on ServerSideException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on NoDataException catch (e) {
      return Left(NoDataFailure(message: e.message));
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, User>> setUserVote(
      User user, Candidate candidate) async {
    try {
      if (await networkInfo.isConnected) {
        final result =
            await remoteDataSource.voteFor(user: user, candidate: candidate);
        if (result == null) {
          return throw ServerSideException();
        }
        await getUser(user.id);
        return Right(result);
      } else {
        throw NetworkException();
      }
    } on ServerSideException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on NoDataException catch (e) {
      return Left(NoDataFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NoDataFailure(message: e.message));
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, User>> registerUser(User user) async {
    try {
      if (await networkInfo.isConnected) {
        final result =
            await remoteDataSource.getUserByPhoneNum(user.identifier);
        if (result == null) {
          return await setUser(user);
        }
        await localDataSource.addUserToCache(result);
        return Right(result);
      } else {
        throw NetworkException();
      }
    } on ServerSideException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on NoDataException catch (e) {
      return Left(NoDataFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NoDataFailure(message: e.message));
    } catch (e) {
      return Left(Failure());
    }
  }
}
