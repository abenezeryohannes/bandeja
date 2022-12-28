import { Optional } from '@nestjs/common';
import { Type } from 'class-transformer';
import { IsNotEmpty } from 'class-validator';

export class PostEditDto {
  @IsNotEmpty({ message: 'Identifier is required!' })
  readonly id: number;

  @Optional()
  readonly desc: string;

  @Optional()
  readonly whatsApp: string;

  @Optional()
  readonly phoneNumber: string;

  @Optional()
  readonly featured: boolean;

  @Optional()
  readonly offer: boolean;

  @Optional()
  @Type(() => Number)
  readonly price: number;

  @Optional()
  readonly enabled: boolean;

  @Optional()
  @Type(() => Number)
  readonly postGroupId: number;

  constructor(body: any) {
    this.id = body.id;
    this.desc = body.desc;
    this.whatsApp = body.whatsApp;
    this.phoneNumber = body.phoneNumber;
    this.offer = body.offer;
    this.price = body.price;
    this.enabled = body.enabled;
  }
}
