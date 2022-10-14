import 'package:dartz/dartz.dart';

import '../../../error/failure.dart';
import '../entities/padel.group.dart';

abstract class IPadelGroupRepository {
  Future<Either<Failure, List<PadelGroupModel>>?>? getPadelGroups({int? page});
  Future<Either<Failure, List<PadelGroupModel>>?>? loadPadelGroups({int? page});
  Future<Either<Failure, PadelGroupModel>?>? getPadelGroup(int id);
}
