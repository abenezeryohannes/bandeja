import { IsNotEmpty } from 'class-validator';

export class FeatureEditDto {
  @IsNotEmpty({ message: 'Identifier is required!' })
  id: number;

  name: string;

  icon: string;

  enabled: boolean;

  constructor(body: any) {
    this.id = body.id;
    this.icon = body.icon;
    this.name = body.name;
    this.enabled = body.enabled;
  }
}
