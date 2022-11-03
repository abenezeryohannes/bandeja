import { IsNotEmpty } from 'class-validator';

export class PadelFeatureDto {
  @IsNotEmpty({ message: 'Feature is required!' })
  readonly featureId: number;

  // @IsNotEmpty({ message: 'Please set the feature amount!' })
  readonly quantity: number;

  readonly free: boolean;
}
