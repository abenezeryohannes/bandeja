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

  @Optional()
  @IsNotEmpty({ message: "Ad's price is required!" })
  @Type(() => Number)
  readonly price: number;

  @Optional()
  readonly enabled: boolean;

  @Optional()
  @IsNotEmpty({ message: 'Ad Group is required!' })
  @Type(() => Number)
  readonly postGroupId: number;
}
