import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/user.dart';

abstract class IUserRepository {
  Future<Either<Failure, UserModel>?>? getUser({String phoneNumber});
  Future<Either<Failure, UserModel>?>? setUser({UserModel user});
  Future<Either<Failure, UserModel>?>? loadUser();
}
