import { IsNotEmpty, IsPhoneNumber, IsEnum } from 'class-validator';

export class ListQueryRequestDto {
  readonly limit: 25;
  readonly page: 1;
}
