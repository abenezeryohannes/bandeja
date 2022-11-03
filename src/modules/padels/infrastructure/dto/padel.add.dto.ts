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
export class PadelAddDto {
  readonly id: number;

  @IsNotEmpty({ message: 'Court name is required!' })
  readonly name: string;

  readonly indoor: boolean;

  // @IsNotEmpty({ message: 'Please select one of the padel groups!' })
  @IsOptional()
  readonly padelGroupIds: [];

  @IsNotEmpty({
    message: 'Please select one of the Locations the court resides!',
  })
  @IsInt()
  @Min(1)
  readonly addressId: number;

  @IsNotEmpty({
    message: 'Court start time is requered!',
  })
  readonly startTime: string;

  @IsNotEmpty({
    message: 'Court end time is requered!',
  })
  readonly endTime: string;

  @IsNotEmpty({
    message: 'Duration must be specified!',
  })
  @IsInt()
  @Min(1)
  readonly durationId: number;

  @IsNotEmpty({
    message: 'Court price for a session is requred!',
  })
  readonly price: number;

  @ValidateNested()
  readonly padelFeatureDto: PadelFeatureDto[];

  @ValidateNested()
  readonly padelSchedules: PadelScheduleAddDto[];

  @ValidateNested()
  readonly locationDto: LocationDto;

  readonly onlyLadies: boolean;

  readonly enabled: boolean;

  constructor(data: any) {
    this.name = data['name'];
    this.indoor = data['indoor'] == 'true' ? true : false;
    this.padelGroupIds = data['padelGroupIds'];
    this.addressId = Number(data['addressId']);
    this.startTime = data['startTime'];
    this.endTime = data['endTime'];
    this.durationId = Number(data['durationId']);
    this.price = Number(data['price']);
    this.padelFeatureDto = JSON.parse(data['padelFeatureDto']);
    this.onlyLadies = data['onlyLadies'] == 'true' ? true : false;
    this.padelSchedules = JSON.parse(data['padelSchedules']);
    this.enabled = data['enabled'] == 'true' ? true : false;
    this.locationDto = JSON.parse(data['locationDto']);
  }
}
