import 'package:bandeja/src/core/domain/padels/entities/duration.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/domain/authentication/entities/user.dart';
import '../../../../core/domain/padels/entities/padel.dart';
import '../../../../core/domain/padels/entities/padel.group.dart';
import '../../../../core/domain/padels/entities/promo.code.dart';
import '../../../../core/error/failure.dart';
import '../../core/entities/address.dart';
import '../../core/entities/location.dart';

abstract class IPadelRepository {
  Future<Either<Failure, PadelModel>?>? getPadel(int id);

  Future<Either<Failure, List<PadelModel>>?>? getFeaturedPadels({
    int? page,
    AddressModel? address,
    LocationModel? location,
    PadelGroupModel? padelGroup,
  });

  Future<Either<Failure, List<PadelModel>>?>? loadFeaturedPadels({
    int? page,
    AddressModel? address,
  });

  Future<Either<Failure, PromoCodeModel>?>? checkPromo(
      {required String promo, required int padelId});

  Future<Either<Failure, List<PadelModel>>?>? getBookmarks({
    int? page,
    int? limit,
    UserModel? user,
  });

  Future<Either<Failure, bool>?>? setBookmark({required int padelId});
  Future<Either<Failure, bool>?>? isBookmark({required int padelId});

  Future<Either<Failure, List<UserModel>>?>? getFilterPadels({
    int? page,
    int? limit,
    bool indoor,
    DurationModel? duration,
    PadelGroupModel? padelGroup,
    AddressModel? address,
    required String date,
    DateTime? timeOfDay,
  });

  Future<Either<Failure, PadelModel>?>? findPadel(
      {required int padelId, DateTime? date});

  Future<Either<Failure, List<DurationModel>>?>? findAllDurations();

  Future<Either<Failure, PadelModel>?>? findPadelWithPeriod(
      {required int padelId,
      required DateTime startTime,
      required DateTime endTime});
}
