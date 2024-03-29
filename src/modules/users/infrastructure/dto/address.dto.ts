import { IsNotEmpty } from 'class-validator';

export class AddressDto {
  readonly id: number;

  @IsNotEmpty({ message: 'Name is required!' })
  readonly name: string;

  readonly enabled: boolean;

  constructor(body: any) {
    this.name = body.name;
    this.enabled = body.enabled;
  }
}
