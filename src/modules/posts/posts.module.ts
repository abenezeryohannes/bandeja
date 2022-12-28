import { Module } from '@nestjs/common';
import { PostsProvider } from './posts.provider';
import { PostsController } from './controllers/posts.controller';
import { PostGroupController } from './controllers/post_group.controller';
import { PostGroupService } from './domain/services/post.group.service';
import { PostsService } from './domain/services/posts.service';
import { DatabaseModule } from '../../core/database/database.module';

@Module({
  imports: [DatabaseModule],
  providers: [PostsService, ...PostsProvider, PostGroupService],
  controllers: [PostsController, PostGroupController],
})
export class PostsModule {}
