import {
  POST_GROUP_REPOSITORY,
  POST_IMAGE_REPOSITORY,
  POST_REPOSITORY,
} from 'src/core/constants';
import { Post } from './domain/entities/post.entity';
import { PostGroup } from './domain/entities/post.group.entity';
import { PostImage } from './domain/entities/post.image.entity';

export const PostsProvider = [
  {
    provide: POST_GROUP_REPOSITORY,
    useValue: PostGroup,
  },
  {
    provide: POST_REPOSITORY,
    useValue: Post,
  },
  {
    provide: POST_IMAGE_REPOSITORY,
    useValue: PostImage,
  },
];
