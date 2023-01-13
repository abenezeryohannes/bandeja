import { IsNotEmpty } from 'class-validator';

export class OrderDto {
  @IsNotEmpty({
    message: 'padel id is required!',
  })
  padelId: number;

  promoCode: string;

  promoCodeId: string;

  @IsNotEmpty({ message: 'Please pick a time first!' })
  padelScheduleId: number;

  constructor(body: any) {
    this.padelId = Number(body['padelId']);
    this.padelScheduleId = Number(body['padelScheduleId']);
    this.promoCodeId = body['promoCodeId'];
    this.promoCode = body['promoCode'];
  }
}
