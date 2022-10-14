import { UserDto } from 'src/modules/users/infrastructure/dto/user.dto';
import { IsNotEmpty } from 'class-validator';

export class NotificationDto {
  userId: number;

  @IsNotEmpty({ message: 'Title is required!' })
  title: string;

  desc: string;

  seen: boolean;

  User: UserDto;
}
