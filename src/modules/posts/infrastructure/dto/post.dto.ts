import { Optional } from '@nestjs/common';
import { Type } from 'class-transformer';
import { IsNotEmpty } from 'class-validator';

export class PostDto {
  @Optional()
  readonly id: number;

  @IsNotEmpty({ message: 'Description is required!' })
  readonly desc: string;

  @Optional()
  readonly whatsApp: string;

  @Optional()
  readonly phoneNumber: string;

  @Optional()
  readonly featured: boolean;

  @Optional()
  readonly offer: boolean;

  @IsNotEmpty({ message: "Ad's price is required!" })
  @Type(() => Number)
  readonly price: number;

  @Optional()
  readonly enabled: boolean;

  @IsNotEmpty({ message: 'Ad Group is required!' })
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
