import { IsNotEmpty } from 'class-validator';
import { PostDto } from 'src/modules/posts/infrastructure/dto/post.dto';
import { PadelGroupDto } from './padel.group';

export class PadelDto {
  readonly id: number;

  @IsNotEmpty({ message: 'Court number is required!' })
  readonly number: number;

  readonly indoor: boolean;

  @IsNotEmpty({ message: 'Please select one of the padel groups!' })
  readonly padel_group_id: number;

  readonly enabled: boolean;

  readonly PadelGroup: PadelGroupDto;

  readonly Post: PostDto;
}
