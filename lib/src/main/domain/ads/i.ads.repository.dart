import 'package:bandeja/src/core/domain/ads/entities/ad.dart';
import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';

abstract class IAdRepository {
  Future<Either<Failure, List<AdModel>>?>? getAds({int? page, int? limit});
}
