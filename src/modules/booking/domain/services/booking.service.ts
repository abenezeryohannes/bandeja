import {
  BadRequestException,
  Inject,
  Injectable,
  NotAcceptableException,
  NotFoundException,
} from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import * as moment from 'moment';
import { Op, Sequelize } from 'sequelize';
import {
  PADEL_ORDER_REPOSITORY,
  PAYMENT_REPOSITORY,
} from '../../../../core/constants';
import { Util } from '../../../../core/utils/util';
import { Address } from '../../../../modules/users/domain/entities/address.entity';
import { Location } from '../../../../modules/users/domain/entities/location.entity';
import { User } from '../../../../modules/users/domain/entities/user.entity';
import { Padel } from '../../../padels/domain/entities/padel.entity';
import { PadelSchedule } from '../../../padels/domain/entities/padel.schedule.entity';
import { PromoCode } from '../../../padels/domain/entities/promo.code.entity';
import { PadelsService } from '../../../padels/domain/services/padels.service';
import { UsersService } from '../../../users/domain/services/users.service';
import { OrderDto } from '../../infrastructure/dto/order.dto';
import { OrderEditDto } from '../../infrastructure/dto/order.edit.dto';
import { OwnerMontlyStatDto } from '../../infrastructure/dto/owner.monthly.stat.dto';
import { PadelOrder } from '../entities/padel.order.entity';
import { Payment } from '../entities/payment.entity';

@Injectable()
export class BookingService {
  constructor(
    @Inject(PADEL_ORDER_REPOSITORY)
    private readonly padelOrderRepository: typeof PadelOrder,
    @Inject(PAYMENT_REPOSITORY)
    private readonly paymentRepository: typeof Payment,
    private readonly padelService: PadelsService,
    private readonly userService: UsersService,
    private readonly jwtService: JwtService,
  ) {}

  async findAll(user: User, query: any): Promise<PadelOrder[]> {
    return await this.padelOrderRepository.findAll({
      where: { userId: user.id },
      include: [
        {
          model: Padel,
          include: [
            { model: Location, required: false },
            { model: Address, required: false },
            { model: User, required: false },
          ],
        },
        { model: PromoCode, required: false },
        { model: PadelSchedule, required: false },
        { model: Payment, required: false },
        { model: User },
      ],
      limit: Util.getLimit(query),
      offset: Util.getOffset(query),
    });
  }

  async book(request: any, orderDto: OrderDto): Promise<PadelOrder> {
    const user = request.user;

    let schedule = await this.padelService.findSchedule(
      orderDto.padelScheduleId,
    );

    const padel = await this.padelService.findOne(
      request.user,
      Date(),
      orderDto.padelId,
    );

    if (
      schedule.startTime.getMilliseconds < moment().toDate().getMilliseconds
    ) {
      throw new BadRequestException('The time has passed pick another one.');
    }

    let order = this.padelOrderRepository.build({
      userId: user.id,
      padelId: orderDto.padelId,
      padelScheduleId: orderDto.padelScheduleId,
      amount: schedule.price == null ? padel.price : schedule.price,
      status: 'pending',
    });

    if (orderDto.promoCode != null) {
      const promoCode = await this.padelService.findOnePromoCode(
        orderDto.promoCode,
        orderDto.padelId,
      );
      if (promoCode == null || promoCode.leftForBooking <= 0) {
        throw new NotFoundException('Invalid promo code!');
      } else {
        order.promoCodeId = promoCode.id;
        order.amount = order.amount - order.amount * (promoCode.discount / 100);
        promoCode.leftForBooking = promoCode.leftForBooking - 1;
        await promoCode.save({ transaction: request.transaction });
      }
    }

    // const padelSchedule = await this.padelService.createPadelSchedule(
    //   orderDto.padelId,
    //   'booked',
    //   new Date(orderDto.startTime),
    //   request.transaction,
    // );
    if (schedule.booked || schedule.status == 'booked') {
      throw new NotAcceptableException(
        'Sorry, court is not free at this time!',
      );
    }
    schedule.booked = true;
    schedule.status = 'booked';
    schedule = await schedule.save({ transaction: request.transaction });
    // order = await order.save({ transaction: request.transaction });
    order.barCode = (
      await this.jwtService.signAsync(order['dataValues'])
    ).substring(0, 254);
    order.PadelSchedule = schedule;
    order = await order.save({ transaction: request.transaction });
    const result = order['dataValues'];
    result.PadelSchedule = schedule['dataValues'];
    return result;
  }

  async findAllOwnerBookings(user: User, query: any): Promise<PadelOrder[]> {
    let condition = {};
    if (query.search != null && query.search != undefined) {
      condition = {
        [Op.or]: [
          { fullName: { [Op.like]: query.search } },
          { phoneNumber: { [Op.like]: query.search } },
        ],
      };
    }
    let timeCondition = {};
    if (
      query.startTime != null &&
      query.startTime != undefined &&
      query.endTime != null &&
      query.endTime != undefined
    ) {
      timeCondition = {
        [Op.and]: [
          { paymentDate: { [Op.gte]: moment(query.startTime).toDate() } },
          { paymentDate: { [Op.lte]: moment(query.endTime).toDate() } },
        ],
      };
    } else if (query.startTime != null && query.startTime != undefined) {
      timeCondition = {
        paymentDate: { [Op.gte]: moment(query.startTime).toDate() },
      };
    } else if (query.endTime != null && query.endTime != undefined) {
      timeCondition = {
        paymentDate: { [Op.lte]: moment(query.endTime).toDate() },
      };
    }

    return await this.padelOrderRepository.findAll({
      //TODO making Op.eq to Op.ne and add ...timeCondidtion on main clause
      where: { paymentId: { [Op.eq]: null } /*, ...timeCondition*/ },
      include: [
        {
          model: Padel,
          where: { userId: user.id },
          include: [Location, Address, User],
        },
        { model: PadelSchedule },
        { model: PromoCode },
        { model: Payment },
        { model: User, where: condition },
      ],
      limit: Util.getLimit(query),
      offset: Util.getOffset(query),
      order: [['id', 'desc']],
    });
  }

  async ownerMonthlyStat(user: User, query: any): Promise<any> {
    const date =
      query.date == null || query.date == undefined
        ? Date()
        : moment(query.date).toDate();
    const startTime = moment(date).startOf('month').toDate();
    const endTime = moment(date).endOf('month').toDate();

    const result = await this.padelOrderRepository.findAll({
      attributes: [
        [Sequelize.fn('count', Sequelize.col('PadelOrder.id')), 'totalVisit'],
        [
          Sequelize.fn(
            'sum',
            Sequelize.fn(
              'TIMESTAMPDIFF',
              Sequelize.literal('minute'),
              Sequelize.col('PadelSchedule.startTime'),
              Sequelize.col('PadelSchedule.endTime'),
            ),
          ),
          'totalHours',
        ],
        [
          Sequelize.fn('sum', Sequelize.col('PadelOrder.amount')),
          'totalincome',
        ],
      ],
      where: {
        [Op.or]: [{ paymentId: { [Op.eq]: null } }, { status: 'confirmed' }],
      },
      include: [
        {
          model: Padel,
          attributes: [],
          required: true,
          where: { userId: user.id },
        },
        { model: Payment, attributes: [] },
        {
          model: PadelSchedule,
          required: true,
          attributes: [],
          where: {
            startTime: { [Op.gte]: startTime },
            endTime: { [Op.lte]: endTime },
          },
        },
      ],
      raw: true,
    });
    return result[0];
  }

  async ownerWeeklyStat(user: User): Promise<any> {
    const startTime = moment(Date()).startOf('week').toDate();
    const endTime = moment(Date()).endOf('week').toDate();

    // const startTime = moment(Date()).endOf('day').toDate();
    // const endTime = moment(Date()).subtract(7, 'days').toDate();
    const result = this.padelOrderRepository.findAll({
      attributes: [
        [
          Sequelize.fn(
            'sum',
            Sequelize.fn(
              'TIMESTAMPDIFF',
              Sequelize.literal('minute'),
              Sequelize.col('PadelSchedule.startTime'),
              Sequelize.col('PadelSchedule.endTime'),
            ),
          ),
          'totalHours',
        ],
        [
          Sequelize.fn('sum', Sequelize.col('PadelOrder.amount')),
          'totalincome',
        ],
        [
          Sequelize.fn(
            'DATE_FORMAT',
            Sequelize.col('PadelSchedule.startTime'),
            '%Y-%m-%d',
          ),
          'date',
        ],
      ],
      where: {
        [Op.or]: [{ paymentId: { [Op.eq]: null } }, { status: 'confirmed' }],
      },
      include: [
        {
          model: Padel,
          attributes: [],
          required: true,
          where: { userId: user.id },
        },
        { model: Payment, attributes: [] },
        {
          model: PadelSchedule,
          required: true,
          attributes: [],
          where: {
            startTime: { [Op.gte]: startTime },
            endTime: { [Op.lte]: endTime },
          },
        },
      ],
      group: ['date'],
      raw: true,
    });
    return result;
  }

  async getpaymentFromSchedule(request: any): Promise<PadelOrder> {
    if (request.body.id == null) {
      throw Error('No id provided to search for!');
    }
    const payment = await this.padelOrderRepository.findOne({
      attributes: { include: [] },
      where: { padelScheduleId: request.body.id },
      include: [Payment, User, Padel],
    });
    if (payment == null) {
      throw Error('No booking details!');
    }
    return payment;
  }

  async getBookingFromQrCode(request: any): Promise<PadelOrder> {
    if (request.body.qrCode == null) {
      throw Error('No QR code provided to search for!');
    }
    const payment = await this.padelOrderRepository.findOne({
      attributes: { include: [] },
      where: { barCode: request.body.qrCode },
      include: [
        { model: Payment },
        { model: User },
        { model: Padel, include: [User] },
      ],
    });
    if (payment == null) {
      throw Error('No booking detail found!');
    }
    return payment;
  }

  async editUserOrder(
    request: any,
    orderEditDto: OrderEditDto,
  ): Promise<PadelOrder> {
    const padelOrder = await this.padelOrderRepository.findByPk(
      orderEditDto.id,
      { include: [{ model: Padel, include: [User] }] },
    );

    if (request.user.id != padelOrder.Padel.User.id) {
      throw Error('You are not authorized to make this change!');
    }

    if (orderEditDto.amount != null && orderEditDto.amount > 0) {
      padelOrder.amount = orderEditDto.amount;
    }

    if (
      orderEditDto.status != null &&
      orderEditDto.status.length > 0 &&
      padelOrder.status != 'confirmed' &&
      padelOrder.status != 'payed' &&
      padelOrder.status != 'paid'
    ) {
      padelOrder.status = orderEditDto.status;
      if (
        orderEditDto.status == 'confirmed' &&
        padelOrder.status == 'pending'
      ) {
        padelOrder.paymentDate = moment().toDate();
      }
    }

    if (orderEditDto.enabled != null) {
      padelOrder.enabled = orderEditDto.enabled;
    }

    if (orderEditDto.promoCodeID != null && orderEditDto.promoCodeID > 0) {
      padelOrder.promoCodeId = orderEditDto.promoCodeID;
    }

    return await padelOrder.save({ transaction: request.transaction });
  }

  async findAllBookings(user: User, query: any): Promise<PadelOrder[]> {
    let condition = {};
    if (query.search != null && query.search != undefined) {
      condition = {
        [Op.or]: [
          { fullName: { [Op.like]: query.search } },
          { phoneNumber: { [Op.like]: query.search } },
        ],
      };
    }
    const mainCondition =
      query.padelId != null ? { padelId: query.padelId } : {};

    return await this.padelOrderRepository.findAll({
      //TODO making Op.eq to Op.ne and add ...timeCondidtion on main clause
      where: { paymentId: { [Op.eq]: null } /*, ...timeCondition*/ },
      include: [
        {
          model: Padel,
          where: mainCondition,
          include: [Location, Address, User],
        },
        { model: PromoCode },
        { model: PadelSchedule },
        { model: Payment },
        { model: User, where: condition },
      ],
      limit: Util.getLimit(query),
      offset: Util.getOffset(query),
      order: [['id', 'desc']],
    });
  }

  async adminMonthlyStat(user: User, query: any): Promise<any> {
    const date =
      query.date == null || query.date == undefined
        ? Date()
        : moment(query.date).toDate();
    const startTime = moment(date).startOf('month').toDate();
    const endTime = moment(date).endOf('month').toDate();

    const result = await this.padelOrderRepository.findAll({
      attributes: [
        [Sequelize.fn('count', Sequelize.col('PadelOrder.id')), 'totalVisit'],
        [
          Sequelize.fn(
            'sum',
            Sequelize.fn(
              'TIMESTAMPDIFF',
              Sequelize.literal('minute'),
              Sequelize.col('PadelSchedule.startTime'),
              Sequelize.col('PadelSchedule.endTime'),
            ),
          ),
          'totalHours',
        ],
        [
          Sequelize.fn('sum', Sequelize.col('PadelOrder.amount')),
          'totalincome',
        ],
      ],
      where: {
        [Op.or]: [{ paymentId: { [Op.eq]: null } }, { status: 'confirmed' }],
      },
      include: [
        {
          model: Padel,
          attributes: [],
          required: true,
        },
        { model: Payment, attributes: [] },
        {
          model: PadelSchedule,
          required: true,
          attributes: [],
          where: {
            startTime: { [Op.gte]: startTime },
            endTime: { [Op.lte]: endTime },
          },
        },
      ],
      raw: true,
    });

    const padelsCount = await this.padelService.countPadels(startTime, endTime);

    //TODO new user's count
    const usersCount = await this.userService.countUsers(startTime, endTime);

    //TODO app visits count
    const appVisitsCount = await this.userService.countAppVisits(
      startTime,
      endTime,
    );

    const response = new OwnerMontlyStatDto({
      totalVisit: result[0]['totalVisit'],
      allHours: await this.padelService.getAllHours(startTime, endTime),
      totalHours: result[0]['totalHours'],
      totalincome: result[0]['totalincome'],
      newUserCount: usersCount,
      padelsCount: padelsCount,
      appVisitsCount: appVisitsCount,
    });

    return response;
  }

  async adminWeeklyStat(user: User): Promise<any> {
    const startTime = moment(Date()).startOf('week').toDate();
    const endTime = moment(Date()).endOf('week').toDate();

    // const startTime = moment(Date()).endOf('day').toDate();
    // const endTime = moment(Date()).subtract(7, 'days').toDate();
    const result = this.padelOrderRepository.findAll({
      attributes: [
        [
          Sequelize.fn(
            'sum',
            Sequelize.fn(
              'TIMESTAMPDIFF',
              Sequelize.literal('minute'),
              Sequelize.col('PadelSchedule.startTime'),
              Sequelize.col('PadelSchedule.endTime'),
            ),
          ),
          'totalHours',
        ],
        [
          Sequelize.fn('sum', Sequelize.col('PadelOrder.amount')),
          'totalincome',
        ],
        [
          Sequelize.fn(
            'DATE_FORMAT',
            Sequelize.col('PadelSchedule.startTime'),
            '%Y-%m-%d',
          ),
          'date',
        ],
      ],
      where: {
        [Op.or]: [{ paymentId: { [Op.eq]: null } }, { status: 'confirmed' }],
      },
      include: [
        {
          model: Padel,
          attributes: [],
          required: true,
        },
        { model: Payment, attributes: [] },
        {
          model: PadelSchedule,
          required: true,
          attributes: [],
          where: {
            startTime: { [Op.gte]: startTime },
            endTime: { [Op.lte]: endTime },
          },
        },
      ],
      group: ['date'],
      raw: true,
    });
    return result;
  }
}
