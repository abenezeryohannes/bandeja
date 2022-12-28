import { Optional } from '@nestjs/common';
import { IsNotEmpty } from 'class-validator';

export class AdEditDto {
  @IsNotEmpty({ message: 'id is required!' })
  readonly id: number;

  @Optional()
  readonly banner: string;

  @Optional()
  readonly link: string;

  @Optional()
  readonly enabled: boolean;

  constructor(body: any) {
    this.id = body.id;
    this.enabled = body.enabled;
    this.banner = body.banner;
    this.link = body.link;
  }
}
