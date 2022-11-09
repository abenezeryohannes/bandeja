import {
  IsPhoneNumber,
  IsEnum,
  IsOptional,
  IsEmail,
  ValidateNested,
} from 'class-validator';
import { LocationDto } from './location.dto';
export enum ROLE {
  USER = 'user',
  ADMIN = 'admin',
  OWNER = 'owner',
}
export class UserEditDto {
  readonly id: number;

  readonly fullName: string;

  @IsOptional()
  @IsPhoneNumber('KW', { message: 'Please, use a valid phone number! ' })
  readonly phoneNumber: string;

  @IsOptional()
  @IsEnum(ROLE, {
    message: 'The role must be one of admin, owner or user. ',
  })
  readonly role: string;

  @IsOptional()
  readonly password: string;

  @IsOptional()
  @IsEmail()
  readonly emailAddress: string;

  @IsOptional()
  readonly enabled: boolean;

  @IsOptional()
  @ValidateNested()
  readonly Location: LocationDto;

  @IsOptional()
  bookingNotification: boolean;

  @IsOptional()
  faceId: boolean;

  constructor(data: any) {
    this.fullName = data['fullName'];
    this.password = data['password'];
    this.Location = data['Location'];
    this.emailAddress = data['emailAddress'];
    this.fullName = data['fullName'];
    this.role = data['role'];

    if (data['enabled'] != undefined && data['enabled'] != null)
      this.enabled = data['enabled'] == 'true' ? true : false;

    if (
      data['bookingNotification'] != undefined &&
      data['bookingNotification'] != null
    )
      this.bookingNotification =
        data['bookingNotification'] == 'true' ? true : false;

    if (data['faceId'] != undefined && data['faceId'] != null)
      this.faceId = data['faceId'] == 'true' ? true : false;

    this.Location = data['location'];
  }
}
