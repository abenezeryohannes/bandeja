import { Module } from '@nestjs/common';
import { DatabaseModule } from '../../core/database/database.module';
import { UsersModule } from '../users/users.module';
import { BookmarkController } from './controllers/bookmark.controller';
import { FeaturesController } from './controllers/features.controller';
import { PadelsController } from './controllers/padels.controller';
import { PadelGroupController } from './controllers/padel_group.controller';
import { BookmarkService } from './domain/services/bookmark.service';
import { FeatureService } from './domain/services/feature.service';
import { PadelsService } from './domain/services/padels.service';
import { PadelGroupService } from './domain/services/padel_group.service';
import { PadelsProvider } from './padels.provider';

@Module({
  imports: [DatabaseModule, UsersModule],
  providers: [
    ...PadelsProvider,
    PadelsService,
    FeatureService,
    PadelGroupService,
    BookmarkService,
  ],
  controllers: [
    FeaturesController,
    PadelsController,
    BookmarkController,
    PadelGroupController,
  ],
  exports: [PadelsService],
})
export class PadelsModule {}
