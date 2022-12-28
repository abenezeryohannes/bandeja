import { AdsService } from './domain/services/ads.service';
import { Module } from '@nestjs/common';
import { AdsController } from './controllers/ads.controller';
import { DatabaseModule } from '../../core/database/database.module';
import { AdsProvider } from './ads.provider';
@Module({
  imports: [DatabaseModule],
  controllers: [AdsController],
  providers: [AdsService, ...AdsProvider],
})
export class AdsModule {}
