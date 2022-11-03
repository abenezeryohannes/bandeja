import { IsIn, IsInt, IsNotEmpty, IsNumber } from 'class-validator';

export class PadelScheduleDto {
  //   @IsNotEmpty({ message: 'A specific court must be selected first!' })
  //   @IsInt()
  //   readonly padelId: number;

  @IsNotEmpty({ message: 'A specific court schedule must be selected first!' })
  @IsInt()
  readonly id: number;

  @IsIn(['booked', 'reserved', 'free'])
  readonly status: string;

  readonly booked: boolean;

  @IsNumber()
  readonly price: number;

  readonly startTime: Date;

  readonly endTime: Date;

  readonly applyForAllDays: boolean;

  constructor(body: any) {
    this.id = Number(body['id']);
    this.price = Number(body['price']);
    this.booked = body['booked'] == 'true';
    this.status = body['status'];
    this.startTime = body['startTime'];
    this.endTime = body['endTime'];
    this.applyForAllDays = body['applyForAllDays'] == 'true';
  }
}
