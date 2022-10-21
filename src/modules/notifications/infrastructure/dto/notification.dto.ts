import { IsNotEmpty } from 'class-validator';
import { UserDto } from '../../../users/infrastructure/dto/user.dto';

export class NotificationDto {
  userId: number;

  @IsNotEmpty({ message: 'Title is required!' })
  title: string;

  desc: string;

  seen: boolean;

  User: UserDto;
}
