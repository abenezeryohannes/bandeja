import { Module } from '@nestjs/common';
import { PostsProvider } from './posts.provider';
import { PostsController } from './controllers/posts.controller';
import { PostGroupController } from './controllers/post_group.controller';
import { PostGroupService } from './domain/services/post.group.service';
import { PostsService } from './domain/services/posts.service';
import { DatabaseModule } from 'src/core/database/database.module';
import { MulterModule } from '@nestjs/platform-express/multer';
import { join } from 'path';

@Module({
  imports: [
    DatabaseModule,
    // MulterModule.register({
    //   dest: join(process.cwd(), 'assets', 'public'),
    // }),
  ],
  providers: [PostsService, ...PostsProvider, PostGroupService],
  controllers: [PostsController, PostGroupController],
})
export class PostsModule {}
