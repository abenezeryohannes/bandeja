import { IsNotEmpty } from 'class-validator';

export class OrderEditDto {
  @IsNotEmpty({
    message: 'Order id is required!',
  })
  id: number;

  amount: number;

  status: string;

  enabled: boolean;

  promoCodeID: number;
  constructor(body: any) {
    this.id = Number(body['id']);
    this.amount = Number(body['amount']);
    this.enabled = body['enabled'];
    this.status = body['status'];
  }
}
