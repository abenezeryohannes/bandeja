import 'package:bandeja/src/admin/data/notification/dto/notification.dto.dart';
import 'package:bandeja/src/admin/data/notification/dto/notification.response.dto.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';

abstract class IAdminNotificationRepository {
  Future<Either<Failure, NotificationResponseDto>?>? send(
      {required NotificationDto notificationDto});
}
