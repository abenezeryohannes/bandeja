import 'package:bandeja/src/core/domain/authentication/entities/user.dart';
import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';

abstract class IAdminUsersRepository {
  Future<Either<Failure, List<UserModel>>?>? getUsers(
      {int? page, int? limit, String? search});
}
