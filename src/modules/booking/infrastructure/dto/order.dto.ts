import { IsDate, IsDateString, IsNotEmpty, IS_DATE } from 'class-validator';

export class OrderDto {
  @IsNotEmpty({
    message: 'No padel identifier presented to perform this task!',
  })
  padelId: number;

  // @IsDate({message: ''})
  // @IsNotEmpty({ message: '!' })
  // endTime: Date;

  // @IsDate({ message: 'Time field must be in date format!' })
  @IsNotEmpty({ message: 'Please pick a time first!' })
  startTime: string;

  promoCode: string;

  // status: string;

  // enabled: boolean;

  // paymentId: number;

  // User: UserDto;

  // Payment: PaymentDto;
}
