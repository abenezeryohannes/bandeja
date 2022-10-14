import { OrderDto } from './order.dto';
import { IsNotEmpty } from 'class-validator';

export class PaymentDto {
  id: number;

  @IsNotEmpty({ message: 'Payed amount is required!' })
  amount: number;

  enabled: boolean;

  Order: OrderDto;
}
