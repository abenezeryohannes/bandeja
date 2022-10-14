import { NOTIFICATION_REPOSITORY } from 'src/core/constants';
import { Notification } from './domain/entities/notification.entity';

export const NotificationsProvider = [
  {
    provide: NOTIFICATION_REPOSITORY,
    useValue: Notification,
  },
];
