import { Sequelize } from 'sequelize-typescript';
import { Token } from '../../modules/auth/domain/entities/token.entity';
import { PadelOrder } from '../../modules/booking/domain/entities/padel.order.entity';
import { Payment } from '../../modules/booking/domain/entities/payment.entity';
import { AllowedBookingHour } from '../../modules/padels/domain/entities/allowed.booking.hour.entity';
import { Bookmark } from '../../modules/padels/domain/entities/bookmark.entity';
import { Duration } from '../../modules/padels/domain/entities/duration.entity';
import { Feature } from '../../modules/padels/domain/entities/feature.entity';
import { Padel } from '../../modules/padels/domain/entities/padel.entity';
import { PadelFeature } from '../../modules/padels/domain/entities/padel.feature';
import { PadelGroup } from '../../modules/padels/domain/entities/padel.group.entity';
import { PadelSchedule } from '../../modules/padels/domain/entities/padel.schedule.entity';
import { PadelPrices } from '../../modules/padels/domain/entities/podel.pricess.entity';
import { PromoCode } from '../../modules/padels/domain/entities/promo.code.entity';
import { Post } from '../../modules/posts/domain/entities/post.entity';
import { PostGroup } from '../../modules/posts/domain/entities/post.group.entity';
import { PostImage } from '../../modules/posts/domain/entities/post.image.entity';
import { Address } from '../../modules/users/domain/entities/address.entity';
import { Setting } from '../../modules/users/domain/entities/setting.entity';
import { Location } from '../../modules/users/domain/entities/location.entity';
import { User } from '../../modules/users/domain/entities/user.entity';
import { Notification } from '../../modules/notifications/domain/entities/notification.entity';

import { SEQUELIZE, DEVELOPMENT, TEST, PRODUCTION } from '../constants';
import { databaseConfig } from './database.config'; 
export const databaseProviders = [
  {
    provide: SEQUELIZE,
    useFactory: async () => {
      let config;
      switch (process.env.NODE_ENV) {
        case DEVELOPMENT:
          config = databaseConfig.development;
          break;
        case TEST:
          config = databaseConfig.test;
          break;
        case PRODUCTION:
          config = databaseConfig.production;
          break;
        default:
          config = databaseConfig.development;
      }
      const sequelize = new Sequelize(config);
      sequelize.addModels([
        User,
        Token,
        Location,
        Address,
        PostImage,
        Bookmark,
        Notification,
        Feature,
        PostGroup,
        Post,
        PadelGroup,
        Padel,
        PadelFeature,
        Payment,
        PadelOrder,
        AllowedBookingHour,
        Duration,
        PadelSchedule,
        PadelPrices,
        PromoCode,
        Setting,
      ]);
      await sequelize.sync({ logging: true });
      return sequelize;
    },
  },
];
