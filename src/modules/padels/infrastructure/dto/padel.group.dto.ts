import { PadelAddDto } from './padel.add.dto';
import { IsNotEmpty } from 'class-validator';

export class PadelGroupDto {
  readonly id: number;

  @IsNotEmpty({ message: 'Name is required!' })
  readonly name: string;

  // @IsNotEmpty({ message: 'Icon is required!' })
  readonly icon: string;

  readonly color: string;

  readonly sequence: number;

  readonly enabled: boolean;

  readonly Padel: PadelAddDto[];

  constructor(body: any) {
    this.color = body.color;
    this.name = body.name;
    this.sequence = body.sequence;
    this.enabled = body.enabled;
    this.icon = body.icon;
  }
}
