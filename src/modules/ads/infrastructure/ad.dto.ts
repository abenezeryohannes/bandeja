import { Optional } from '@nestjs/common';
import { IsNotEmpty } from 'class-validator';

export class AdDto {
  @Optional()
  readonly id: number;

  @IsNotEmpty({ message: 'Banner is required!' })
  readonly banner: string;

  @Optional()
  readonly link: string;

  @Optional()
  readonly enabled: boolean;

  constructor(body: any) {
    this.id = body.id;
    this.banner = body.banner;
    this.link = body.link;
    this.enabled = body.enabled;
  }
}
