import { IsNotEmpty } from 'class-validator';

export class PostGroupEditDto {
  @IsNotEmpty({ message: 'Identifier is required!' })
  id: number;

  name: string;
  icon: string;
  color: string;
  sequence: number;
  enabled: boolean;

  constructor(body: any) {
    this.id = body.id;
    this.name = body.name;
    this.icon = body.icon;
    this.color = body.color;
    this.sequence = body.sequence;
    this.enabled = body.enabled;
  }
}
