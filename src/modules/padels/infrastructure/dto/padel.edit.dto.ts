import {
  IsInt,
  IsNotEmpty,
  IsOptional,
  Min,
  ValidateNested,
} from 'class-validator';
import { LocationDto } from '../../../users/infrastructure/dto/location.dto';
import { PadelFeatureDto } from './padel.feature.dto';
import { PadelScheduleAddDto } from './padel.schedule.add.dto';
export class PadelEditDto {
  @IsNotEmpty({ message: 'Court id is required!' })
  @Min(1)
  @IsInt()
  id: number;

  @IsOptional()
  readonly name: string;

  @IsOptional()
  readonly userId: number;

  @IsOptional()
  readonly indoor: boolean;

  @IsOptional()
  readonly padelGroupIds: [];

  @IsOptional()
  @IsInt()
  @Min(1)
  readonly addressId: number;

  @IsOptional()
  readonly startTime: string;

  @IsOptional()
  readonly endTime: string;

  @IsOptional()
  @IsInt()
  @Min(1)
  readonly durationId: number;

  @IsOptional()
  readonly price: number;

  @IsOptional()
  readonly approved: boolean;

  @ValidateNested()
  readonly padelFeatureDto: PadelFeatureDto[];

  @ValidateNested()
  readonly locationDto: LocationDto;

  @ValidateNested()
  readonly padelSchedules: PadelScheduleAddDto[];

  @IsOptional()
  readonly onlyLadies: boolean;

  @IsOptional()
  readonly enabled: boolean;

  constructor(data: any) {
    this.id = Number(data['id']);
    this.name = data['name'];
    this.userId = Number(data['userId']);
    this.indoor = data['indoor'] || data['indoor'] == 'true';
    this.padelGroupIds = data['padelGroupId'];
    this.addressId = Number.isNaN(Number(data['addressId']))
      ? null
      : Number(data['addressId']);
    this.startTime = data['startTime'];
    this.endTime = data['endTime'];
    this.durationId = Number.isNaN(Number(data['durationId']))
      ? null
      : Number(data['durationId']);
    this.price = Number(data['price']);
    this.approved = data['approved'] || data['approved'] == 'true';
    if (data['padelFeatureDto'] != null || data['padelFeatureDto'] != undefined)
      this.padelFeatureDto = JSON.parse(data['padelFeatureDto']);
    this.onlyLadies =
      data['onlyLadies'] == null
        ? null
        : data['onlyLadies'] || data['onlyLadies'] == 'true';
    if (data['padelSchedules'] != null || data['padelSchedules'] != undefined)
      this.padelSchedules = JSON.parse(data['padelSchedules']);
    this.enabled = data['enabled'] || data['enabled'] == 'true';
    if (data['locationDto'] != null || data['locationDto'] != undefined)
      this.locationDto = JSON.parse(data['locationDto']);
  }
}
