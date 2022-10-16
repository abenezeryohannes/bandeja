import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/posts/entities/post.group.dart';
import '../../../error/failure.dart';
import '../../../network/network.info.dart';
import '../../../domain/posts/repositories/i.post.group.repository.dart';
import '../post_group/post.group.local.data.source.dart';
import '../post_group/post.group.remote.data.source.dart';

@Singleton(as: IPostGroupRepository)
class PostGroupRepository implements IPostGroupRepository {
  late INetworkInfo networkInfo;
  late PostGroupLocalDataSource localDataSource;
  late PostGroupRemoteDataSource remoteDataSource;

  PostGroupRepository(
      {required this.networkInfo,
      required this.localDataSource,
      required this.remoteDataSource});

  @override
  Future<Either<Failure, PostGroupModel>?>? getPostGroup(int id) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.getPostGroup(id);
        if (response == null) return null;
        await localDataSource.savePostGroup(response);
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
  Future<Either<Failure, List<PostGroupModel>>?>? loadPostGroups(
      {int? page}) async {
    try {
      final result = await localDataSource.loadPostGroups(page);
      if (result == null || result == []) throw Failure.noDataFailure();
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure.unExpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PostGroupModel>>?>? getPostGroups(
      {int? page}) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.getPostGroups(page);
        if (response == null) return null;
        await localDataSource.savePostGroups(page, response);
        return Right(response);
      } else {
        final result = await localDataSource.loadPostGroups(page);
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
