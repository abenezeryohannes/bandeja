import { IsNotEmpty } from 'class-validator';

export class OrderDto {
  @IsNotEmpty({
    message: 'padel id is required!',
  })
  padelId: number;

  // @IsDate({message: ''})
  // @IsNotEmpty({ message: '!' })
  // endTime: Date;

  // @IsDate({ message: 'Time field must be in date format!' })
  // @IsNotEmpty({ message: 'Please pick a time first!' })
  // startTime: string;

  promoCode: string;
  promoCodeId: string;

  @IsNotEmpty({ message: 'Please pick a time first!' })
  padelScheduleId: number;

  // status: string;

  // enabled: boolean;

  // paymentId: number;

  // User: UserDto;

  // Payment: PaymentDto;

  constructor(body: any) {
    this.padelId = Number(body['padelId']);
    this.padelScheduleId = Number(body['padelScheduleId']);
    this.promoCodeId = body['promoCodeId'];
    this.promoCode = body['promoCode'];
  }
}
