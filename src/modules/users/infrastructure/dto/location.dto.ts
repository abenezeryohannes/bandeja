import { UserDto } from './user.dto';

export class LocationDto {
  readonly id: number;

  readonly latitude: number;

  readonly longitude: number;

  readonly Users: UserDto[];
}
