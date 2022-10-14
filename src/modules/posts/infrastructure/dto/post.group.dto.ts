import { IsNotEmpty } from 'class-validator';
import { PostDto } from './post.dto';

export class PostGroupDto {
  id: number;

  @IsNotEmpty({ message: 'Name is required!' })
  name: string;

  icon: string;

  color: string;

  sequence: number;

  enabled: boolean;

  Posts: PostDto[];
}
