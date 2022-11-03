import { IsIn, IsInt, IsNotEmpty, IsNumber } from 'class-validator';

export class PadelScheduleAddDto {
  @IsIn(['booked', 'reserved', 'free'])
  readonly status: string;

  readonly booked: boolean;

  @IsNumber()
  readonly price: number;

  readonly startTime: Date;

  readonly endTime: Date;

  readonly applyForAllDays: boolean;
}
