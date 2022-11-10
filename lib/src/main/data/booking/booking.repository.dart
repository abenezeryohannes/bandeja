import 'package:bandeja/src/core/error/failure.dart';
import 'package:bandeja/src/core/domain/booking/entities/padel.order.dart';
import 'package:bandeja/src/core/network/network.info.dart';
import 'package:bandeja/src/main/data/booking/source/booking.local.data.source.dart';
import 'package:bandeja/src/main/data/booking/source/booking.remote.data.source.dart';
import 'package:bandeja/src/main/data/dto/padel.order.dto.dart';
import 'package:bandeja/src/main/domain/booking/repositories/i.booking.repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: IBookingRepository)
class BookingRepository extends IBookingRepository {
  final INetworkInfo networkInfo;
  final BookingLocalDataSource localDataSource;
  final BookingRemoteDataSource remoteDataSource;

  BookingRepository(
      {required this.networkInfo,
      required this.localDataSource,
      required this.remoteDataSource});

  @override
  Future<Either<Failure, PadelOrderModel>?>? book(
      {required PadelOrderDto order}) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.book(order: order);
        if (response == null) throw UnExpectedFailure();
        return Right(response);
      } else {
        throw NetworkFailure();
      }
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure.unExpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PadelOrderModel>>?>? myBooking(
      {int? page, int? limit}) async {
    try {
      if (await networkInfo.isConnected) {
        final response =
            await remoteDataSource.getBookings(page: page, limit: limit);
        if (response == null) return null;
        await localDataSource.savePadelOrder(page, response);
        return Right(response);
      } else {
        final result = await localDataSource.loadBooking(page);
        if (result == null) return null;
        return Right(result);
      }
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure.unExpectedFailure(message: e.toString()));
    }
  }
}
