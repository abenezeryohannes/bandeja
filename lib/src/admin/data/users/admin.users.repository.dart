import 'package:bandeja/src/admin/data/users/source/admin.users.local.data.source.dart';
import 'package:bandeja/src/admin/data/users/source/admin.users.remote.data.source.dart';
import 'package:dartz/dartz.dart';
import 'package:bandeja/src/core/error/failure.dart';
import 'package:bandeja/src/core/domain/authentication/entities/user.dart';
import 'package:injectable/injectable.dart';

import '../../../core/network/network.info.dart';
import '../../domain/users/i.admin.users.repository.dart';

@Singleton(as: IAdminUsersRepository)
class AdminUsersRepository implements IAdminUsersRepository {
  INetworkInfo networkInfo;
  AdminUsersRemoteDataSource remoteDataSource;
  AdminUsersLocalDataSource localDataSource;

  AdminUsersRepository(
      {required this.networkInfo,
      required this.remoteDataSource,
      required this.localDataSource});

  @override
  Future<Either<Failure, List<UserModel>>?>? getUsers(
      {int? page, int? limit, String? search}) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.getUsers(
          page: page,
          search: search,
          limit: limit,
        );
        if (response == null) return const Right([]);
        await localDataSource.saveUsers(page, response);
        return Right(response);
      } else {
        final result = await localDataSource.loadUsers(page);
        if (result == null) return throw CacheFailure();
        return Right(result);
      }
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure.unExpectedFailure(message: e.toString()));
    }
  }
}
