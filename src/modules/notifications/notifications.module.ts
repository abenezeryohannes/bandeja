import { Module } from '@nestjs/common';
import { NotificationsController } from './controllers/notifications.controller';
import { NotificationsService } from './domain/services/notifications.service';
import { NotificationsProvider } from './notifications.provider';

@Module({
  providers: [NotificationsService, ...NotificationsProvider],
  controllers: [NotificationsController],
})
export class NotificationsModule {}
