import { PAYMENT_REPOSITORY, PADEL_ORDER_REPOSITORY } from 'src/core/constants';
import { Payment } from './domain/entities/payment.entity';
import { PadelOrder } from './domain/entities/padel.order.entity';

export const BookingProvider = [
  {
    provide: PAYMENT_REPOSITORY,
    useValue: Payment,
  },
  {
    provide: PADEL_ORDER_REPOSITORY,
    useValue: PadelOrder,
  },
];
