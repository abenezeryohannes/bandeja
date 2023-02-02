import { Module } from '@nestjs/common';
import { JwtModule } from '@nestjs/jwt';
import { DatabaseModule } from '../../core/database/database.module';
import { NotificationsModule } from '../notifications/notifications.module';
import { PadelsModule } from '../padels/padels.module';
import { UsersModule } from '../users/users.module';
import { BookingProvider } from './booking.providers';
import { BookingController } from './controllers/booking.controller';
import { BookingService } from './domain/services/booking.service';

@Module({
  imports: [
    PadelsModule,
    UsersModule,
    NotificationsModule,
    DatabaseModule,
    JwtModule.register({
      secret: process.env.JWTKEY,
    }),
  ],
  providers: [BookingService, ...BookingProvider],
  controllers: [BookingController],
})
export class BookingModule {}
