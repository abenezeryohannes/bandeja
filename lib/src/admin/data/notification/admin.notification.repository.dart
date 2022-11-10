import 'package:bandeja/src/admin/data/notification/dto/notification.response.dto.dart';
import 'package:bandeja/src/admin/data/notification/dto/notification.dto.dart';
import 'package:bandeja/src/admin/data/notification/source/admin.notification.local.data.source.dart';
import 'package:bandeja/src/admin/data/notification/source/admin.notification.remote.data.source.dart';
import 'package:dartz/dartz.dart';
import 'package:bandeja/src/core/error/failure.dart';
import 'package:injectable/injectable.dart';

import '../../../core/network/network.info.dart';
import '../../domain/notification/i.admin.notification.repository.dart';

@Singleton(as: IAdminNotificationRepository)
class AdminNotificationRepository implements IAdminNotificationRepository {
  INetworkInfo networkInfo;
  AdminNotificationRemoteDataSource remoteDataSource;
  AdminNotificationLocalDataSource localDataSource;

  AdminNotificationRepository(
      {required this.networkInfo,
      required this.remoteDataSource,
      required this.localDataSource});

  @override
  Future<Either<Failure, NotificationResponseDto>?>? send(
      {required NotificationDto notificationDto}) async {
    try {
      if (await networkInfo.isConnected) {
        final response =
            await remoteDataSource.send(notificationDto: notificationDto);
        if (response == null) throw Failure.serverFailure();
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
