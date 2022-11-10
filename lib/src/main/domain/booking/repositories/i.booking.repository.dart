import 'package:dartz/dartz.dart';

import '../../../../core/domain/booking/entities/padel.order.dart';
import '../../../../core/error/failure.dart';
import '../../../data/dto/padel.order.dto.dart';

abstract class IBookingRepository {
  Future<Either<Failure, PadelOrderModel>?>? book(
      {required PadelOrderDto order});
  Future<Either<Failure, List<PadelOrderModel>>?>? myBooking(
      {int? page, int? limit});
}
