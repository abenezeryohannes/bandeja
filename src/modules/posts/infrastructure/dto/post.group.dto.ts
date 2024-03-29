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

  constructor(body: any) {
    this.id = body.id;
    this.name = body.name;
    this.icon = body.icon;
    this.color = body.color;
    this.sequence = body.sequence;
    this.enabled = body.enabled;
  }
}
