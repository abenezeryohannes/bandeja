import { Sequelize } from 'sequelize-typescript';
import { Post } from 'src/modules/posts/domain/entities/post.entity';
import { PostGroup } from 'src/modules/posts/domain/entities/post.group.entity';
import { Token } from 'src/modules/auth/domain/entities/token.entity';
import { Payment } from 'src/modules/booking/domain/entities/payment.entity';
import { Bookmark } from 'src/modules/padels/domain/entities/bookmark.entity';
import { Notification } from 'src/modules/notifications/domain/entities/notification.entity';
import { Feature } from 'src/modules/padels/domain/entities/feature.entity';
import { Padel } from 'src/modules/padels/domain/entities/padel.entity';
import { PadelGroup } from 'src/modules/padels/domain/entities/padel.group.entity';
import { PadelFeature } from 'src/modules/padels/domain/entities/padel.feature';
import { Address } from 'src/modules/users/domain/entities/address.entity';
import { Location } from 'src/modules/users/domain/entities/location.entity';
import { User } from 'src/modules/users/domain/entities/user.entity';
import { SEQUELIZE, DEVELOPMENT, TEST, PRODUCTION } from '../constants';
import { databaseConfig } from './database.config';
import { PostImage } from 'src/modules/posts/domain/entities/post.image.entity';
import { PadelOrder } from 'src/modules/booking/domain/entities/padel.order.entity';
import { AllowedBookingHour } from 'src/modules/padels/domain/entities/allowed.booking.hour.entity';
import { Duration } from 'src/modules/padels/domain/entities/duration.entity';
import { PadelSchedule } from 'src/modules/padels/domain/entities/padel.schedule.entity';
import { PadelPrices } from 'src/modules/padels/domain/entities/podel.pricess.entity';
import { PromoCode } from 'src/modules/padels/domain/entities/promo.code.entity';
import { Setting } from 'src/modules/users/domain/entities/setting.entity';
import { TransactionInterceptor } from './decorators/transaction.interceptor';
import { APP_INTERCEPTOR } from '@nestjs/core';
import { Scope } from '@nestjs/common';

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
