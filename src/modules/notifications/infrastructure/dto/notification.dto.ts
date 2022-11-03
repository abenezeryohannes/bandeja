import { IsNotEmpty } from 'class-validator';
import { UserDto } from '../../../users/infrastructure/dto/user.dto';

export class NotificationDto {
  userId: number;

  @IsNotEmpty({ message: 'Title is required!' })
  title: string;

  desc: string;

  seen: boolean;

  token: string;

  role: string;

  User: UserDto;

  constructor(data: any) {
    this.title = data.title;
    this.desc = data.desc;
    this.seen = data.seen;
    this.token = data.fcm;
    this.role = data.role;
    this.userId = data.userId;
  }
}
