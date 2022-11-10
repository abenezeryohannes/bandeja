import 'package:dartz/dartz.dart';

import '../../../../core/data/posts/dto/post.dto.dart';
import '../../../../core/domain/posts/entities/post.dart';
import '../../../../core/domain/posts/entities/post.group.dart';
import '../../../../core/error/failure.dart';
import '../../core/entities/address.dart';
import '../../core/entities/location.dart';

abstract class IPostRepository {
  Future<Either<Failure, List<PostModel>>?>? getMyPosts(
      {int? page, int? limit});

  Future<Either<Failure, List<PostModel>>?>? getOffers({
    int? page,
  });
  Future<Either<Failure, List<PostModel>>?>? getWants({
    int? page,
  });
  Future<Either<Failure, List<PostModel>>?>? getPosts(
      {int? page,
      int? limit,
      AddressModel? address,
      LocationModel? location,
      PostGroupModel? itemGroup,
      bool? offers});

  Future<Either<Failure, PostModel>?>? getPost({required int id});

  Future<Either<Failure, bool>?>? deletePost({required int id});

  Future<Either<Failure, PostModel>?>? addPost(
      {required List<String> imagePaths, required PostDto post});

  Future<Either<Failure, List<PostModel>>?>? getFeaturedPosts({
    int? page,
    AddressModel? address,
    LocationModel? location,
  });
  Future<Either<Failure, List<PostModel>>?>? loadFeaturedPosts({
    AddressModel? address,
    int? page,
  });
}