import { ForbiddenException, Inject, Injectable } from '@nestjs/common';
import { Sequelize } from 'sequelize-typescript';
import { Op } from 'sequelize';
import {
  BOOKING_DURATION_REPOSITORY,
  PADEL_FEATURE_REPOSITORY,
  PADEL_REPOSITORY,
  PADEL_SCHEDULE_REPOSITORY,
  PROMO_CODE_REPOSITORY,
  SEQUELIZE,
  USER_REPOSITORY,
} from 'src/core/constants';
import { User } from 'src/modules/users/domain/entities/user.entity';
import { Location } from 'src/modules/users/domain/entities/location.entity';
import { Padel } from '../entities/padel.entity';
import { PadelFeature } from '../entities/padel.feature';
import { Address } from 'src/modules/users/domain/entities/address.entity';
import { Util } from 'src/core/utils/util';
import { Feature } from '../entities/feature.entity';
import { PadelSchedule } from '../entities/padel.schedule.entity';
import { PromoCode } from '../entities/promo.code.entity';
import { Duration } from '../entities/duration.entity';
import * as moment from 'moment';
import { FilterPadelDto } from '../../infrastructure/dto/filter.padel.dto';
import { UsersService } from 'src/modules/users/domain/services/users.service';

@Injectable()
export class PadelsService {
  constructor(
    @Inject(PADEL_FEATURE_REPOSITORY)
    private readonly padelFeaturesRepository: typeof PadelFeature,

    @Inject(PADEL_REPOSITORY) private readonly padelsRepository: typeof Padel,

    @Inject(BOOKING_DURATION_REPOSITORY)
    private readonly durationsRepository: typeof Duration,

    @Inject(PADEL_SCHEDULE_REPOSITORY)
    private readonly padelScheduleRepository: typeof PadelSchedule,

    @Inject(PROMO_CODE_REPOSITORY)
    private readonly promoCodeRepository: typeof PromoCode,

    private readonly userService: UsersService,

    @Inject(SEQUELIZE) private readonly sequelize: typeof Sequelize,
  ) {}

  async featured(user: User, query: any): Promise<Padel[]> {
    const latitude = user['Location']['latitude'];
    const longitude = user['Location']['longitude'];
    return await this.padelsRepository.findAll({
      attributes: {
        include: [
          [
            this.sequelize.literal(
              `SQRT( ((${latitude}-latitude)*(${latitude}-latitude)) +  ((${longitude}-longitude)*(${longitude}-longitude)) )`,
            ),
            'distance',
          ],
        ],
      },
      where: { enabled: true },
      include: [
        { model: User, include: [] },
        { model: Location },
        { model: Duration },
        { model: Address },
      ],
      limit: Util.getLimit(query),
      offset: Util.getOffset(query),
      order: [['distance', 'asc']],
    });
  }

  async findOne(date: string, id: number): Promise<Padel> {
    const startDate = moment(date).startOf('day').toDate();
    const endDate = moment(date).endOf('day').toDate();
    return await this.padelsRepository.findByPk(id, {
      include: [
        { model: Location },
        { model: User },
        { model: Duration },
        { model: Address },
        { model: Feature },
        {
          model: PadelSchedule,
          required: false,
          where: {
            startTime: { [Op.gte]: startDate },
            endTime: { [Op.lte]: endDate },
          },
        },
      ],
    });
  }
  async findOnePromoCode(
    promoCode: string,
    padelId: number,
  ): Promise<PromoCode> {
    return await this.promoCodeRepository.findOne({
      where: { code: promoCode, padelId: padelId },
    });
  }

  async createPadelSchedule(
    padelId: number,
    reason: string,
    startTime: Date,
    transaction: any,
  ): Promise<PadelSchedule> {
    const schedule = this.padelScheduleRepository.build({
      reason: reason,
      padelId: padelId,
      startTime: startTime,
    });
    const padel = await this.padelsRepository.findByPk(padelId);
    const duration = await this.durationsRepository.findOne({
      where: { id: padel.durationId },
    });
    schedule.endTime = moment(startTime).add(duration.minute, 'm').toDate();

    //if the time is write and no one booked
    const check = await this.padelScheduleRepository.findOne({
      where: {
        padelId: padelId,
        startTime: { [Op.lt]: startTime },
        endTime: { [Op.gt]: startTime },
      },
    });
    if (
      check != null ||
      startTime < padel.startTime ||
      padel.endTime < startTime
    ) {
      throw new ForbiddenException(
        'Sorry the padel is already booked or unavailable at this time.',
      );
    }

    return await schedule.save({ transaction: transaction });
  }

  async findAllPadels(filterPadelsDto: FilterPadelDto): Promise<User[]> {
    const isFullDay = filterPadelsDto.date.length <= 12;

    const startTime = moment(filterPadelsDto.date).toDate();

    const endTime = isFullDay
      ? moment(filterPadelsDto.date).endOf('day').toDate()
      : moment(filterPadelsDto.date).toDate();

    return await this.userService.filterOwnersPadel(
      startTime,
      endTime,
      filterPadelsDto,
    );
  }
}
