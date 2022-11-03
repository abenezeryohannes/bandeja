import { IsNotEmpty } from 'class-validator';
export class PromoCodeDto {
  readonly id: number;

  @IsNotEmpty({ message: 'Promo code is required' })
  readonly code: string;

  @IsNotEmpty({
    message: 'Pick a padel first that the promo code applies to !',
  })
  readonly padelId: number;

  @IsNotEmpty({
    message: 'Discount percentage required!',
  })
  readonly discount: number;

  @IsNotEmpty({
    message:
      'The number of times the promo code can be applied to is required!',
  })
  readonly maxBooking: number;

  constructor(body: any) {
    this.id = body['id'];
    this.code = body['code'];
    this.padelId = body['padelId'];
    this.discount = body['discount'];
    this.maxBooking = body['maxBooking'];
  }
}
