import { Inject, Injectable } from '@nestjs/common';
import { NOTIFICATION_REPOSITORY } from 'src/core/constants';
import { User } from 'src/modules/users/domain/entities/user.entity';
import { Notification } from 'src/modules/notifications/domain/entities/notification.entity';
import { Util } from 'src/core/utils/util';
import { seenDto } from '../../infrastructure/dto/seen.dto';

@Injectable()
export class NotificationsService {
  constructor(
    @Inject(NOTIFICATION_REPOSITORY)
    private readonly notificationRepository: typeof Notification,
  ) {}

  async findAll(user: User, query: any): Promise<Notification[]> {
    return await this.notificationRepository.findAll({
      where: { userId: user.id },
      limit: Util.getLimit(query),
      offset: Util.getOffset(query),
    });
  }
  async seen(request: any, seen: seenDto): Promise<Notification> {
    const notification = await this.notificationRepository.findByPk(
      seen.notificationId,
    );
    notification.seen = true;
    return await notification.save({ transaction: request.transaction });
  }
  async clear(request: any): Promise<Notification[]> {
    await this.notificationRepository.destroy({
      where: { userID: request.user.id },
      transaction: request.transaction,
    });
    return await this.notificationRepository.findAll({
      where: { userId: request.user.id },
    });
  }
}
