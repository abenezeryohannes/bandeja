import 'package:bandeja/src/core/domain/padels/entities/padel.dart';
import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';

abstract class IAdminPadelRepository {
  Future<Either<Failure, List<PadelModel>>?>? getPadels(
      {int? page, int? limit, String? search, bool? enabled});

  Future<Either<Failure, List<PadelModel>>?>? getPadelsForApproval(
      {int? page, int? limit, String? search, bool? approved});

  Future<Either<Failure, int>?>? countAllPadels();
}
