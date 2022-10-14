import { Optional } from '@nestjs/common';
import { IsNotEmpty, isNumber } from 'class-validator';

export class FilterPadelDto {
  @Optional()
  readonly addressId: number;

  @IsNotEmpty({ message: 'Please pick a time frame first!' })
  readonly date: string;

  readonly padelGroupId: number;
}
