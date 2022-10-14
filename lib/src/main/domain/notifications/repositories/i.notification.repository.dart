import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/notification.dart';

abstract class INotificationRepository {
  Future<Either<Failure, List<NotificationModel>>?>? getNotifications({
    int? page,
  });
}
