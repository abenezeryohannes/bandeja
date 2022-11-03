import { Optional } from '@nestjs/common';
import { IsNotEmpty } from 'class-validator';

export class FilterPadelDto {
  @Optional()
  readonly addressId: number;

  @IsNotEmpty({ message: 'Please pick a time frame first!' })
  // @IsDateString()
  readonly date: string;

  @Optional()
  readonly padelGroupId: number;

  constructor(data: any) {
    this.addressId = data['addressId'];
    this.date = data['date'];
    this.padelGroupId = data['padelGroupId'];
  }
}
