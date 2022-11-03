import { PadelAddDto } from './padel.add.dto';
import { IsNotEmpty } from 'class-validator';

export class PadelGroupDto {
  readonly id: number;

  @IsNotEmpty({ message: 'Name is required!' })
  readonly name: string;

  readonly icon: string;

  readonly color: string;

  readonly sequence: number;

  readonly enabled: boolean;

  readonly Padel: PadelAddDto[];
}
