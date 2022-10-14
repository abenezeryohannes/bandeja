import { TokenDto } from '../../../auth/infrastructure/dto/token.dto';
import { IsNotEmpty, IsPhoneNumber, IsEnum } from 'class-validator';
export enum ROLE {
  USER = 'user',
  ADMIN = 'admin',
  OWNER = 'owner',
}
export class UserDto {
  readonly id: number;

  // @IsNotEmpty({ message: 'Name is required! ' })
  readonly fullName: string;

  @IsNotEmpty({ message: 'Phone number is required ! ' })
  @IsPhoneNumber('KW', { message: 'Please, use a valid phone number! ' })
  readonly phoneNumber: string;

  @IsNotEmpty({ message: 'Un-Authenticated user! ' })
  readonly UID: string;

  readonly avatar: string;

  @IsEnum(ROLE, {
    message: 'The role must be one of admin, owner or user. ',
  })
  @IsNotEmpty({ message: 'Role is required! ' })
  readonly role: string;

  readonly enabled: boolean;

  readonly Token: TokenDto;
}
