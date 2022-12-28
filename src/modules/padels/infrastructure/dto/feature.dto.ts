import { IsNotEmpty } from 'class-validator';

export class FeatureDto {
  id: number;

  @IsNotEmpty({ message: 'Name is required!' })
  name: string;

  @IsNotEmpty({ message: 'Icon is required!' })
  icon: string;

  enabled: boolean;

  constructor(body: any) {
    this.icon = body.icon;
    this.name = body.name;
    this.enabled = body.enabled;
  }
}
