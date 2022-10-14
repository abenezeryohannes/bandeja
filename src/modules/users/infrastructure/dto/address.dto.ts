import { IsNotEmpty } from 'class-validator';

export class AddressDto {
  readonly id: number;

  @IsNotEmpty({ message: 'Name is required!' })
  readonly name: string;

  readonly enabled: boolean;
}
