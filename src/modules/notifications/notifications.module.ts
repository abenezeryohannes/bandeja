import { Module } from '@nestjs/common';
import { AuthModule } from '../auth/auth.module';
import { UsersModule } from '../users/users.module';
import { NotificationsController } from './controllers/notifications.controller';
import { NotificationsService } from './domain/services/notifications.service';
import { NotificationsProvider } from './notifications.provider';

@Module({
  imports: [UsersModule, AuthModule],
  providers: [NotificationsService, ...NotificationsProvider],
  controllers: [NotificationsController],
  exports: [NotificationsService],
})
export class NotificationsModule {}
