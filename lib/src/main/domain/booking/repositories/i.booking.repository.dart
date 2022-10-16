import 'package:dartz/dartz.dart';

import '../../../../core/domain/authentication/entities/user.dart';
import '../../../../core/domain/booking/entities/padel.order.dart';
import '../../../../core/error/failure.dart';

abstract class IBookingRepository {
  Future<Either<Failure, PadelOrderModel>?>? book(
      {UserModel user, PadelOrderModel book});
  Future<Either<Failure, List<PadelOrderModel>>?>? myBooking(
      {int? page, UserModel? user});
}
