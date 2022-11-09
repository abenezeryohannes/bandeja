import { IsOptional, Min } from 'class-validator';
import { UserDto } from './user.dto';

export class LocationDto {
  readonly id: number;

  @IsOptional()
  @Min(0, { message: 'Invalid Location latitude must be greater than' })
  readonly latitude: number;

  @Min(0, { message: 'Invalid Location longitude must be greater than' })
  readonly longitude: number;

  @Min(0, { message: '' })
  readonly address: string;

  readonly Users: UserDto[];

  constructor(data: any) {
    this.id = data.id;
    this.latitude = data.latitude;
    this.longitude = data.longitude;
    this.address = data.address;
  }
}
