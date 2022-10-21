import { Payment } from './domain/entities/payment.entity';
import { PadelOrder } from './domain/entities/padel.order.entity';
import {
  PADEL_ORDER_REPOSITORY,
  PAYMENT_REPOSITORY,
} from '../../core/constants';

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
