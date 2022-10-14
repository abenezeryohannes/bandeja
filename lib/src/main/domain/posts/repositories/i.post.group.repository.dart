import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/post.group.dart';

abstract class IPostGroupRepository {
  Future<Either<Failure, List<PostGroupModel>>?>? getPostGroups({int? page});
  Future<Either<Failure, List<PostGroupModel>>?>? loadPostGroups({int? page});
  Future<Either<Failure, PostGroupModel>?>? getPostGroup(int id);
}
