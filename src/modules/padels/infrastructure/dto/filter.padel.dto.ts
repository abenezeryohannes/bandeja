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

  @Optional()
  readonly durationId: number;

  @Optional()
  readonly indoor: string;

  constructor(data: any) {
    this.addressId = data['addressId'];
    this.date = data['date'];
    this.padelGroupId = data['padelGroupId'];
    this.indoor = data['indoor'];
    this.durationId = data['durationId'];
  }
}
