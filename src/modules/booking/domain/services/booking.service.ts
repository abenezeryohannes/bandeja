import {
  BadRequestException,
  Inject,
  Injectable,
  NotAcceptableException,
  NotFoundException,
} from '@nestjs/common';
import * as moment from 'moment';
import { MOMENT, PADEL_ORDER_REPOSITORY } from 'src/core/constants';
import { Util } from 'src/core/utils/util';
import { Padel } from 'src/modules/padels/domain/entities/padel.entity';
import { PromoCode } from 'src/modules/padels/domain/entities/promo.code.entity';
import { PadelsService } from 'src/modules/padels/domain/services/padels.service';
import { Address } from 'src/modules/users/domain/entities/address.entity';
import { Location } from 'src/modules/users/domain/entities/location.entity';
import { User } from 'src/modules/users/domain/entities/user.entity';
import { OrderDto } from '../../infrastructure/dto/order.dto';
import { PadelOrder } from '../entities/padel.order.entity';
import { Payment } from '../entities/payment.entity';

@Injectable()
export class BookingService {
  constructor(
    @Inject(PADEL_ORDER_REPOSITORY)
    private readonly padelOrderRepository: typeof PadelOrder,
    private readonly padelService: PadelsService,
  ) {}

  async findAll(user: User, query: any): Promise<PadelOrder[]> {
    return await this.padelOrderRepository.findAll({
      where: { id: user.id },
      include: [
        { model: Padel, include: [Location, Address] },
        { model: PromoCode },
        { model: Payment },
        { model: User },
      ],
      limit: Util.getLimit(query),
      offset: Util.getOffset(query),
    });
  }

  async book(request: any, orderDto: OrderDto): Promise<PadelOrder> {
    const user = request.user;
    if (Date.parse(orderDto.startTime) < Date.now()) {
      throw new BadRequestException('The time has passed pick another one.');
    }
    const order = this.padelOrderRepository.build({
      userId: user.id,
      padelId: orderDto.padelId,
      status: 'pending',
    });
    if (orderDto.promoCode != null) {
      const promoCode = await this.padelService.findOnePromoCode(
        orderDto.promoCode,
        orderDto.padelId,
      );
      if (promoCode == null) {
        throw new NotFoundException('Invalid promo code!');
      }
      order.promoCodeID = promoCode.id;
    }
    const padelSchedule = await this.padelService.createPadelSchedule(
      orderDto.padelId,
      'booked',
      new Date(orderDto.startTime),
      request.transaction,
    );
    if (padelSchedule == null) {
      throw new NotAcceptableException("Sorry, couldn't set this schedule!");
    }
    order.padelScheduleId = padelSchedule.id;
    return await order.save({ transaction: request.transaction });
  }
}
