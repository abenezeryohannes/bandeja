import 'package:dartz/dartz.dart';
import 'package:feekpadel/src/main/domain/booking/entities/padel.order.dart';

import '../../../../core/error/failure.dart';
import '../../authentication/entities/user.dart';

abstract class IBookingRepository {
  Future<Either<Failure, PadelOrderModel>?>? book(
      {UserModel user, PadelOrderModel book});
  Future<Either<Failure, List<PadelOrderModel>>?>? myBooking(
      {int? page, UserModel? user});
}
