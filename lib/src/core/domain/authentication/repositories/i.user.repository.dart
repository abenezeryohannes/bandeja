import 'package:bandeja/src/core/data/authentication/dto/location.dto.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../data/authentication/dto/user.dto.dart';
import '../entities/user.dart';
import '../entities/system.variable.dart';

abstract class IUserRepository {
  Future<Either<Failure, UserModel>?>? editUser({required UserDto user});
  Future<Either<Failure, bool>?>? logoutUser();
  Future<Either<Failure, UserModel>?>? loginUser({required UserDto user});
  Future<Either<Failure, UserModel>?>? signupUser({required UserDto user});
  Future<Either<Failure, UserModel>?>? loadUser();
  Future<Either<Failure, UserModel>?>? getUser({required int id});
  Future<Either<Failure, UserModel>?>? setFCMToken({required String token});
  Future<Either<Failure, String?>?>? getSystemVariable({required String key});
  Future<Either<Failure, SystemVariableModel>?>? setSystemVariable(
      {required String key, required String val});
  Future<Either<Failure, bool>?>? onAppVisit({required int padelId});
  Future<Either<Failure, bool>?>? onAppVisitEnd({required int padelId});
  Future<Either<Failure, bool>?>? updateLocation(
      {required LocationDto locationDto});
}
