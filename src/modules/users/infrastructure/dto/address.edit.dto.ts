import { IsNotEmpty } from 'class-validator';

export class AddressEditDto {
  @IsNotEmpty({ message: 'Identifier is required!' })
  readonly id: number;

  readonly name: string;

  readonly enabled: boolean;

  constructor(body: any) {
    this.id = body.id;
    this.name = body.name;
    this.enabled = body.enabled;
  }
}
