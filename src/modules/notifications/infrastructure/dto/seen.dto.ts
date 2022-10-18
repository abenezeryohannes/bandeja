import { IsNotEmpty } from 'class-validator';

export class seenDto {
  @IsNotEmpty({ message: 'notification identifier is required!' })
  readonly notificationId: number;
}
