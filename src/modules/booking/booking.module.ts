import { Module } from '@nestjs/common';
import { DatabaseModule } from '../../core/database/database.module';
import { PadelsModule } from '../padels/padels.module';
import { BookingProvider } from './booking.providers';
import { BookingController } from './controllers/booking.controller';
import { BookingService } from './domain/services/booking.service';

@Module({
  imports: [PadelsModule, DatabaseModule],
  providers: [BookingService, ...BookingProvider],
  controllers: [BookingController],
})
export class BookingModule {}
