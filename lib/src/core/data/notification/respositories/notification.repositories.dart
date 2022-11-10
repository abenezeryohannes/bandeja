import 'package:bandeja/src/core/domain/notifications/entities/notification.dart';
import 'package:bandeja/src/core/domain/notifications/repositories/i.notification.repository.dart';
import 'package:dartz/dartz.dart';
import 'package:bandeja/src/core/error/failure.dart';
import 'package:injectable/injectable.dart';

import '../../../network/network.info.dart';
import '../source/notification.local.data.source.dart';
import '../source/notification.remote.data.source.dart';

@Singleton(as: INotificationRepository)
class NotificationRepsotory implements INotificationRepository {
  late INetworkInfo networkInfo;
  late NotificationRemoteDataSource remoteDataSource;
  late NotificationLocalDataSource localDataSource;

  NotificationRepsotory(
      {required this.networkInfo,
      required this.localDataSource,
      required this.remoteDataSource});

  @override
  Future<Either<Failure, List<NotificationModel>>?>? getNotifications(
      {int? page, int? limit}) async {
    try {
      if (await networkInfo.isConnected) {
        final response =
            await remoteDataSource.getNotifications(page: page, limit: limit);
        await localDataSource.saveNotifications(page, response);
        return Right(response);
      } else {
        final result = await localDataSource.loadNotifications();
        if (result == null) return null;
        return Right(result);
      }
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure.unExpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<NotificationModel>>?>? getUnSeenNotifications(
      {int? page, int? limit}) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.getUnSeenNotifications(
            page: page, limit: limit);
        await localDataSource.saveUnSeenNotifications(page, response);
        return Right(response);
      } else {
        final result = await localDataSource.loadUnSeenNotifications();
        if (result == null) return null;
        return Right(result);
      }
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure.unExpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>?>? countUnseenNotifications() async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.countUnseenNotifications();
        await localDataSource.savetUnseenNotificationsCount(response);
        return Right(response);
      } else {
        final result = await localDataSource.countUnseenNotifications();
        if (result == null) return null;
        return Right(result);
      }
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(Failure.unExpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, NotificationModel>?>? makeNotificationSeen(
      {required int notificationId}) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.makeNotificationSeen(
            notificationId: notificationId);
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
  Future<Either<Failure, List<NotificationModel>>?>?
      clearNotifications() async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.clearNotifications();
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
}
