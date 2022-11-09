import { IsNotEmpty, IsNumber } from 'class-validator';
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
    if (IsNumber(body['id'])) this.padelId = Number(body['id']);
    this.code = body['code'];
    if (IsNumber(body['padelId'])) this.padelId = Number(body['padelId']);
    if (IsNumber(body['discount'])) this.discount = Number(body['discount']);
    if (IsNumber(body['maxBooking']))
      this.maxBooking = Number(body['maxBooking']);
  }
}
