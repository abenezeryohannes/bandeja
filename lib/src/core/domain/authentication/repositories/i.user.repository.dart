import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../data/authentication/dto/user.dto.dart';
import '../entities/user.dart';

abstract class IUserRepository {
  Future<Either<Failure, UserModel>?>? editUser({required UserDto user});
  Future<Either<Failure, UserModel>?>? loginUser({required UserModel user});
  Future<Either<Failure, UserModel>?>? signupUser({required UserModel user});
  Future<Either<Failure, UserModel>?>? loadUser();
}
