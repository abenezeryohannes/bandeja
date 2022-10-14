import 'package:dartz/dartz.dart';
import 'package:feekpadel/src/main/domain/core/entities/address.dart';
import 'package:feekpadel/src/main/domain/core/entities/location.dart';
import '../../../../core/error/failure.dart';
import '../../authentication/entities/user.dart';
import '../entities/padel.dart';
import '../entities/padel.group.dart';

abstract class IPadelRepository {
  Future<Either<Failure, PadelModel>?>? getPadel(int id);

  Future<Either<Failure, List<PadelModel>>?>? getFeaturedPadels({
    int? page,
    AddressModel? address,
    LocationModel? location,
  });

  Future<Either<Failure, List<PadelModel>>?>? loadFeaturedPadels({
    int? page,
    AddressModel? address,
  });

  Future<Either<Failure, List<PadelModel>>?>? getBookmarks({
    int? page,
    int? limit,
    UserModel? user,
  });
  Future<Either<Failure, List<UserModel>>?>? getFilterPadels({
    int? page,
    int? limit,
    bool indoor,
    PadelGroupModel? padelGroup,
    AddressModel? address,
    required String date,
    DateTime? timeOfDay,
  });
}
