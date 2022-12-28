import { PadelAddDto } from './padel.add.dto';
import { IsNotEmpty } from 'class-validator';

export class PadelGroupEditDto {
  @IsNotEmpty({ message: 'Id is required!' })
  readonly id: number;

  readonly name: string;

  readonly icon: string;

  readonly color: string;

  readonly sequence: number;

  readonly enabled: boolean;

  readonly Padel: PadelAddDto[];

  constructor(body: any) {
    this.id = body.id;
    this.color = body.color;
    this.name = body.name;
    this.sequence = body.sequence;
    this.enabled = body.enabled;
    this.icon = body.icon;
  }
}
