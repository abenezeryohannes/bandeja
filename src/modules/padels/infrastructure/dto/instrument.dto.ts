import { IsNotEmpty } from 'class-validator';

export class InstrumentDto {
  readonly id: number;

  @IsNotEmpty({ message: 'Name is required!' })
  readonly name: string;

  readonly icon: string;

  readonly enabled: boolean;
}
