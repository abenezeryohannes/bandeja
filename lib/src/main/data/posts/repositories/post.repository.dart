import 'package:dartz/dartz.dart';
import 'package:feekpadel/src/main/data/posts/dto/post.dto.dart';
import 'package:feekpadel/src/main/domain/posts/entities/post.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/network/network.info.dart';
import '../../../domain/core/entities/address.dart';
import '../../../domain/core/entities/location.dart';
import '../../../domain/posts/entities/post.group.dart';
import '../../../domain/posts/repositories/i.post.repository.dart';
import '../source/post/post.local.datasource.dart';
import '../source/post/post.remote.datasource.dart';

@Singleton(as: IPostRepository)
class PostRepository implements IPostRepository {
  late INetworkInfo networkInfo;
  late PostRemoteDataSource remoteDataSource;
  late PostLocalDataSource localDataSource;

  PostRepository(
      {required this.networkInfo,
      required this.remoteDataSource,
      required this.localDataSource});

  @override
  Future<Either<Failure, PostModel>?>? getPost({required int id}) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.getAdvert(id);
        if (response == null) return null;
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
  Future<Either<Failure, List<PostModel>>?>? getPosts(
      {int? page,
      AddressModel? address,
      PostGroupModel? itemGroup,
      LocationModel? location,
      bool? offers}) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.getPosts(
            page: page,
            offers: offers,
            location: location,
            itemGroup: itemGroup,
            address: address);
        if (response == null) return null;
        await localDataSource.savePosts(page, response);
        return Right(response);
      } else {
        final result = await localDataSource.loadPosts(page);
        if (result == null) return null;
        return Right(result);
      }
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure.unExpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PostModel>>?>? getFeaturedPosts(
      {LocationModel? location, AddressModel? address, int? page}) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.getFeaturedPosts(page);
        if (response == null) return null;
        await localDataSource.saveFeaturedPosts(page, response);
        return Right(response);
      } else {
        final result = await localDataSource.loadFeaturedPosts(page);
        if (result == null) return null;
        return Right(result);
      }
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure.unExpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PostModel>>?>? getOffers({int? page}) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.getOffers(page);
        if (response == null) return null;
        await localDataSource.saveOffers(page, response);
        return Right(response);
      } else {
        final result = await localDataSource.loadOffers(page);
        if (result == null) return null;
        return Right(result);
      }
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure.unExpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PostModel>>?>? getWants({int? page}) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.getWants(page);
        if (response == null) return null;
        await localDataSource.saveWants(page, response);
        return Right(response);
      } else {
        final result = await localDataSource.loadWants(page);
        if (result == null) return null;
        return Right(result);
      }
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure.unExpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PostModel>>?>? loadFeaturedPosts(
      {LocationModel? location, AddressModel? address, int? page}) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.getFeaturedPosts(page);
        if (response == null) return null;
        await localDataSource.saveFeaturedPosts(page, response);
        return Right(response);
      } else {
        final result = await localDataSource.loadFeaturedPosts(page);
        if (result == null) return null;
        return Right(result);
      }
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure.unExpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PostModel>>?>? getMyPosts(
      {int? page, int? limit}) async {
    try {
      if (await networkInfo.isConnected) {
        final response =
            await remoteDataSource.getMyPosts(page: page, limit: limit);
        if (response == null) return null;
        await localDataSource.saveMyPosts(page, response);
        return Right(response);
      } else {
        final result = await localDataSource.loadMyPosts(page);
        if (result == null) return null;
        return Right(result);
      }
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure.unExpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PostModel>?>? addPost(
      {required List<String> imagePaths, required PostDto post}) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.addPost(
            imageFilePaths: imagePaths, post: post);
        if (response == null) return null;
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
  Future<Either<Failure, PostModel>?>? deletePost({required int id}) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.deletePost(id);
        if (response == null) return null;
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
