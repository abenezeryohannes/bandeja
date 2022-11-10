import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/notification.dart';

abstract class INotificationRepository {
  Future<Either<Failure, List<NotificationModel>>?>? getNotifications(
      {int? page, int? limit});
  Future<Either<Failure, List<NotificationModel>>?>? getUnSeenNotifications(
      {int? page, int? limit});
  Future<Either<Failure, NotificationModel>?>? makeNotificationSeen({
    required int notificationId,
  });
  Future<Either<Failure, List<NotificationModel>>?>? clearNotifications();
  Future<Either<Failure, int>?>? countUnseenNotifications();
}
