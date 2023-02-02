import { ForbiddenException, Inject, Injectable } from '@nestjs/common';
import { Sequelize } from 'sequelize-typescript';
import { Op } from 'sequelize';
import { Padel } from '../entities/padel.entity';
import { PadelFeature } from '../entities/padel.feature';
import { Feature } from '../entities/feature.entity';
import { PadelSchedule } from '../entities/padel.schedule.entity';
import { PromoCode } from '../entities/promo.code.entity';
import { Duration } from '../entities/duration.entity';
import * as moment from 'moment';
import { FilterPadelDto } from '../../infrastructure/dto/filter.padel.dto';
import {
  BOOKING_DURATION_REPOSITORY,
  FEATURE_REPOSITORY,
  PADEL_FEATURE_REPOSITORY,
  PADEL_PADEL_GROUP_REPOSITORY,
  PADEL_REPOSITORY,
  PADEL_SCHEDULE_REPOSITORY,
  PROMO_CODE_REPOSITORY,
  SEQUELIZE,
} from '../../../../core/constants';
import { UsersService } from '../../../users/domain/services/users.service';
import { User } from '../../../users/domain/entities/user.entity';
import { Location } from '../../../users/domain/entities/location.entity';
import { Address } from '../../../users/domain/entities/address.entity';
import { Util } from '../../../../core/utils/util';
import { PromoCodeDto } from '../../infrastructure/dto/promo.code.dto';
import { PadelAddDto } from '../../infrastructure/dto/padel.add.dto';
import { join } from 'path';
import { PadelScheduleDto } from '../../infrastructure/dto/padel.schedule.dto';
import { PadelEditDto } from '../../infrastructure/dto/padel.edit.dto';
import { PadelPadelGroup } from '../entities/padel.padel.group';
import { PadelGroupService } from './padel_group.service';
import { PadelGroup } from '../entities/padel.group.entity';
import { Bookmark } from '../entities/bookmark.entity';
import { isNumber } from 'class-validator';
import { LocationDto } from '../../../users/infrastructure/dto/location.dto';
import { AppVisit } from '../../../users/domain/entities/app.visit.entity';

@Injectable()
export class PadelsService {
  constructor(
    private readonly padelGroupService: PadelGroupService,

    @Inject(FEATURE_REPOSITORY)
    private readonly featuresRepository: typeof Feature,

    @Inject(PADEL_FEATURE_REPOSITORY)
    private readonly padelFeaturesRepository: typeof PadelFeature,

    @Inject(PADEL_REPOSITORY) private readonly padelsRepository: typeof Padel,

    @Inject(BOOKING_DURATION_REPOSITORY)
    private readonly durationsRepository: typeof Duration,

    @Inject(PADEL_SCHEDULE_REPOSITORY)
    private readonly padelScheduleRepository: typeof PadelSchedule,

    @Inject(PROMO_CODE_REPOSITORY)
    private readonly promoCodeRepository: typeof PromoCode,

    @Inject(PADEL_PADEL_GROUP_REPOSITORY)
    private readonly padelPadelGroupRepository: typeof PadelPadelGroup,

    private readonly userService: UsersService,

    @Inject(SEQUELIZE) private readonly sequelize: typeof Sequelize,
  ) {}

  async findSchedule(padelScheduleId: number): Promise<PadelSchedule> {
    return await this.padelScheduleRepository.findByPk(padelScheduleId);
  }

  async featured(user: User, query: any): Promise<Padel[]> {
    const latitude = user.Location != null ? user.Location.latitude : 0;
    const longitude = user.Location != null ? user.Location.longitude : 0;

    const startDate = moment(query.date == null ? Date() : query.date)
      .startOf('day')
      .toDate();

    const endDate = moment(query.date == null ? Date() : query.date)
      .endOf('day')
      .toDate();

    let condition = null;
    if (query.padelGroupId != null) condition = { id: query.padelGroupId };

    const addressCondition = [];
    if (query.addressId != null) addressCondition.push({ id: query.addressId });

    const filteredPadelIds = await this.padelsRepository.findAll({
      attributes: [
        ['id', 'id'],
        [
          this.sequelize.literal(
            `SQRT( ((${latitude}-latitude)*(${latitude}-latitude)) +  ((${longitude}-longitude)*(${longitude}-longitude)) )`,
          ),
          'distance',
        ],
      ],
      where: { enabled: true, approved: true },
      include: [
        {
          model: User,
          where: { enabled: true },
          attributes: [],
          required: false,
        },
        { model: Location, attributes: [], required: false },
        {
          model: Address,
          include: addressCondition,
          attributes: [],
          required: false,
        },
      ],
      limit: Util.getLimit(query),
      offset: Util.getOffset(query),
      order: [['distance', 'asc']],
    });

    return await this.padelsRepository.findAll({
      where: { id: { [Op.in]: filteredPadelIds.map((e) => e.id) } },
      include: [
        { model: User, include: [] },
        { model: Location, required: false },
        { model: Feature, required: false },
        { model: Duration, required: false },
        { model: Address, required: false },
        { model: PadelGroup, where: condition },
        { model: Bookmark, where: { userId: user.id }, required: false },
        {
          model: PadelSchedule,
          required: false,
          where: {
            startTime: { [Op.gte]: startDate },
            endTime: { [Op.lte]: endDate },
          },
        },
      ],
      limit: Util.getLimit(query),
      offset: Util.getOffset(query),
      // order: [['distance', 'asc']],
    });
  }

  async findOne(user: User, date: string, id: number): Promise<Padel> {
    const startDate = moment(date).startOf('day').toDate();
    const endDate = moment(date).endOf('day').toDate();
    return await this.padelsRepository.findByPk(id, {
      include: [
        { model: Location },
        { model: User },
        { model: Duration },
        { model: Address },
        { model: Feature },
        { model: Bookmark, where: { userId: user.id }, required: false },
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

    return await this.userService.filterPadels(
      startTime,
      endTime,
      filterPadelsDto,
    );
  }

  async findAllOwnerPadelsWithSchedules(
    user: User,
    filterPadelsDto: FilterPadelDto,
  ): Promise<Padel[]> {
    const isFullDay = filterPadelsDto.date.length <= 12;

    const startTime = moment(filterPadelsDto.date).toDate();

    const endTime = isFullDay
      ? moment(filterPadelsDto.date).endOf('day').toDate()
      : moment(filterPadelsDto.date).toDate();

    const conditions = { enabled: true };
    if (filterPadelsDto.addressId != null) {
      conditions['addressId'] = filterPadelsDto.addressId;
    }
    if (filterPadelsDto.padelGroupId != null) {
      conditions['padelGroupId'] = filterPadelsDto.padelGroupId;
    }
    return await this.padelsRepository.findAll({
      where: { userId: user.id, ...conditions },
      include: [
        { model: Location },
        { model: Address },
        { model: Duration },
        { model: Feature },
        { model: User },
        { model: Bookmark, where: { userId: user.id }, required: false },
        {
          model: PadelSchedule,
          required: false,
          where: {
            startTime: { [Op.gte]: startTime },
            endTime: { [Op.lte]: endTime },
          },
        },
      ],
    });
  }

  async getVisits(
    userId: number | null,
    padelId: number | null,
  ): Promise<AppVisit[]> {
    return await this.userService.getPadelVisits(userId, padelId);
  }

  async getVisitsCount(
    userId: number | null,
    padelId: number | null,
  ): Promise<number> {
    return await this.userService.getPadelVisitsCount(userId, padelId);
  }

  async findOneWithPeriod(request: any): Promise<Padel> {
    const startTime = moment(
      request.query.startTime == null ? Date() : request.query.startTime,
    )
      .startOf('day')
      .toDate();
    const endTime = moment(
      request.query.endTime == null ? Date() : request.query.endTime,
    )
      .endOf('day')
      .toDate();

    return await this.padelsRepository.findByPk(request.query.padelId, {
      include: [
        { model: Location },
        { model: Address },
        { model: Duration },
        { model: Feature },
        { model: User },
        {
          model: Bookmark,
          where: { userId: request.user.id },
          required: false,
        },
        {
          model: PadelSchedule,
          required: false,
          where: {
            startTime: { [Op.gte]: startTime },
            endTime: { [Op.lte]: endTime },
          },
        },
      ],
    });
  }

  async addPadel(request: any, padelDto: PadelAddDto): Promise<Padel> {
    let padel = this.padelsRepository.build({
      userId: request.user.id,
      name: padelDto.name,
      addressId: padelDto.addressId,
      durationId: padelDto.durationId,
      onlyLadies: padelDto.onlyLadies,
      indoor: padelDto.indoor,
      price: Number.parseFloat(padelDto.price.toString()),
    });

    //START TIME
    if (padelDto.startTime != null) {
      padel.startTime = moment(padelDto.startTime).toDate();
    } else padel.startTime = moment().startOf('day').add(2, 'hours').toDate();

    //END TIME
    if (padelDto.endTime != null) {
      padel.endTime = moment(padelDto.endTime).toDate();
    } else padel.endTime = moment().startOf('day').add(14, 'hours').toDate();

    //AVATAR
    if (
      request.files != null &&
      request.files.avatar != null &&
      request.files.avatar.length > 0
    )
      padel.avatar = join('public', request.files.avatar[0].filename);

    //BANNER
    if (
      request.files != null &&
      request.files.banner != null &&
      request.files.banner.length > 0
    )
      padel.banner = join('public', request.files.banner[0].filename);

    //PADEL Location
    if (padelDto.locationDto != null) {
      const location = await this.userService.addLocation(padelDto.locationDto);
      padel.locationId = location.id;
    }

    padel = await padel.save({ transaction: request.transaction });

    //PADEL GROUP
    if (padelDto.padelGroupIds != null && padelDto.padelGroupIds.length >= 0) {
      const ops = [];
      padelDto.padelGroupIds.forEach((groupId) => {
        ops.push({
          padelId: padel.id,
          padelGroupId: groupId,
        });
      });
      await this.padelPadelGroupRepository.bulkCreate(ops, {
        transaction: request.transaction,
      });
    }

    if (padelDto.onlyLadies != null) {
      const ladies = await this.padelGroupService.findOneByName('Ladies');
      if (padel.indoor && ladies != null) {
        await this.padelPadelGroupRepository.create(
          {
            padelId: padel.id,
            padelGroupId: ladies.id,
          },
          { transaction: request.transaction },
        );
      }
    }

    if (padelDto.indoor != null) {
      const outdoor = await this.padelGroupService.findOneByName('Outdoor');
      const indoor = await this.padelGroupService.findOneByName('Indoor');
      if (padel.indoor) {
        if (indoor != null)
          await this.padelPadelGroupRepository.create(
            {
              padelId: padel.id,
              padelGroupId: indoor.id,
            },
            { transaction: request.transaction },
          );
      } else {
        if (outdoor != null)
          await this.padelPadelGroupRepository.create(
            {
              padelId: padel.id,
              padelGroupId: outdoor.id,
            },
            { transaction: request.transaction },
          );
      }
    }

    //FEATURES
    if (
      padelDto.padelFeatureDto != null &&
      padelDto.padelFeatureDto.length > 0
    ) {
      const ops = [];
      padelDto.padelFeatureDto.forEach((padelFeatureDto) => {
        ops.push({
          padelId: padel.id,
          featureId: padelFeatureDto.featureId,
          quantity: 1,
          free: padelFeatureDto.free == null ? true : padelFeatureDto.free,
        });
      });
      // await Promise.all(ops);
      await this.padelFeaturesRepository.bulkCreate(ops, {
        transaction: request.transaction,
      });
    }
    //SCHEDULES
    if (padelDto.padelSchedules != null && padelDto.padelSchedules.length > 0) {
      const ops2 = [];
      padelDto.padelSchedules.forEach((schedule) => {
        for (let i = 0; i < 100; i++) {
          ops2.push(
            // this.padelScheduleRepository.create(
            {
              padelId: padel.id,
              status:
                (schedule.applyForAllDays || i == 0) && schedule.status != null
                  ? schedule.status
                  : 'free',
              booked:
                schedule.applyForAllDays || i == 0
                  ? schedule.booked == null
                    ? false
                    : schedule.booked
                  : false,
              price:
                isNaN(schedule.price) && (schedule.applyForAllDays || i == 0)
                  ? padel.price
                  : schedule.price,
              startTime: moment(schedule.startTime).add(i, 'days').toDate(),
              endTime: moment(schedule.endTime).add(i, 'days').toDate(),
            },
            //, { transaction: request.transaction },
            // ),
          );
        }
      });
      await this.padelScheduleRepository.bulkCreate(ops2, {
        transaction: request.transaction,
      });
      // await Promise.all(ops2);
    }

    //groups

    return padel;
  }

  async editPadel(request: any, padelDto: PadelEditDto): Promise<Padel> {
    let updatePrice = false;
    let padel = await this.padelsRepository.findByPk(padelDto.id, {
      include: [Address],
    });
    if (padel == null) {
      throw Error('Court not found!');
    }

    if (padelDto.approved != null) {
      padel.approved = padelDto.approved;
    }

    if (padelDto.name != null) {
      padel.name = padelDto.name;
    }

    if (
      padelDto.userId != null &&
      isNumber(padelDto.userId) &&
      padelDto.userId > 0
    ) {
      padel.userId = padelDto.userId;
    }

    if (padelDto.enabled != null) {
      padel.enabled = padelDto.enabled;
    }

    if (
      padelDto.addressId != null &&
      !isNaN(padelDto.addressId) &&
      padelDto.addressId > 0
    ) {
      padel.addressId = padelDto.addressId;
    }

    if (
      padelDto.durationId != null &&
      !isNaN(padelDto.durationId) &&
      padelDto.durationId > 0
    ) {
      padel.durationId = padelDto.durationId;
    }

    //PADEL GROUP
    if (padelDto.padelGroupIds != null && padelDto.padelGroupIds.length >= 0) {
      await this.padelPadelGroupRepository.destroy({
        where: { padelId: padel.id },
      });
      const ops = [];
      padelDto.padelGroupIds.forEach((groupId) => {
        ops.push({
          padelId: padel.id,
          padelGroupId: groupId,
        });
      });
      await this.padelFeaturesRepository.bulkCreate(ops, {
        transaction: request.transaction,
      });
    }

    if (padelDto.onlyLadies != null) {
      padel.onlyLadies = padelDto.onlyLadies;
      const ladies = await this.padelGroupService.findOneByName('Ladies');
      if (ladies != null)
        await this.padelPadelGroupRepository.destroy({
          where: {
            padelId: padel.id,
            padelGroupId: ladies.id,
          },
          transaction: request.transaction,
        });
      if (padel.indoor && ladies != null) {
        await this.padelPadelGroupRepository.create(
          {
            padelId: padel.id,
            padelGroupId: ladies.id,
          },
          { transaction: request.transaction },
        );
      }
    }
    if (padelDto.indoor != null) {
      padel.indoor = padelDto.indoor;

      const outdoor = await this.padelGroupService.findOneByName('Outdoor');
      const indoor = await this.padelGroupService.findOneByName('Indoor');
      if (indoor != null)
        await this.padelPadelGroupRepository.destroy({
          where: {
            padelId: padel.id,
            padelGroupId: indoor.id,
          },
          transaction: request.transaction,
        });
      if (outdoor != null)
        await this.padelPadelGroupRepository.destroy({
          where: {
            padelId: padel.id,
            padelGroupId: outdoor.id,
          },
          transaction: request.transaction,
        });
      if (padel.indoor) {
        if (indoor != null)
          await this.padelPadelGroupRepository.create(
            {
              padelId: padel.id,
              padelGroupId: indoor.id,
            },
            { transaction: request.transaction },
          );
      } else {
        if (outdoor != null)
          await this.padelPadelGroupRepository.create(
            {
              padelId: padel.id,
              padelGroupId: outdoor.id,
            },
            { transaction: request.transaction },
          );
      }
    }
    if (
      padelDto.price != null &&
      !isNaN(padelDto.price) &&
      padelDto.price > 0
    ) {
      updatePrice = padel.price != padelDto.price;
      padel.price = padelDto.price;
    }

    //START TIME
    if (padelDto.startTime != null) {
      // padel.startTime = padelDto.startTime; //new Date(padelDto.startTime);
      padel.startTime = moment.utc(padelDto.startTime).toDate();
    }
    //END TIME
    if (padelDto.endTime != null) {
      // padel.endTime = padelDto.startTime; //new Date(padelDto.endTime);
      padel.endTime = moment.utc(padelDto.endTime).toDate();
    }
    //PADEL Location
    if (
      padelDto.locationDto != null &&
      padelDto.locationDto.latitude != null &&
      padelDto.locationDto.longitude != null
    ) {
      if (padel.locationId == null && padelDto.locationDto.id == null) {
        const location = await this.userService.addLocation(
          padelDto.locationDto,
        );
        padel.locationId = location.id;
      } else {
        const dto = new LocationDto({
          id: padel.locationId,
          latitude: padelDto.locationDto.latitude,
          longitude: padelDto.locationDto.longitude,
          address: padelDto.locationDto.address,
        });
        await this.userService.editLocation(dto);
      }
    }

    //AVATAR
    if (
      request.files != null &&
      request.files.avatar != null &&
      request.files.avatar.length > 0
    )
      padel.avatar = join('public', request.files.avatar[0].filename);

    //BANNER
    if (
      request.files != null &&
      request.files.banner != null &&
      request.files.banner.length > 0
    )
      padel.banner = join('public', request.files.banner[0].filename);

    padel = await padel.save({ transaction: request.transaction });

    //FEATURES
    if (
      padelDto.padelFeatureDto != null &&
      padelDto.padelFeatureDto.length >= 0
    ) {
      await this.padelFeaturesRepository.destroy({
        where: { padelId: padel.id },
      });
      const ops = [];
      padelDto.padelFeatureDto.forEach((padelFeatureDto) => {
        ops.push({
          padelId: padel.id,
          featureId: padelFeatureDto.featureId,
          quantity: 1,
          free: padelFeatureDto.free == null ? true : padelFeatureDto.free,
        });
      });
      await this.padelFeaturesRepository.bulkCreate(ops, {
        transaction: request.transaction,
      });
    }

    //SCHEDULES
    if (
      padelDto.padelSchedules != null &&
      padelDto.padelSchedules.length >= 0
    ) {
      const firstPossibleOrderForEdit =
        await this.padelScheduleRepository.findAll({
          where: {
            padelId: padel.id,
            status: { [Op.ne]: 'free' },
          },
          order: [['id', 'desc']],
        });
      let dayDif = 0;
      if (firstPossibleOrderForEdit.length > 0) {
        const possibleToStart = firstPossibleOrderForEdit[0].startTime;
        await this.padelScheduleRepository.destroy({
          where: {
            padelId: padel.id,
            status: { [Op.eq]: 'free' },
            startTime: { [Op.gt]: possibleToStart },
          },
          transaction: request.transaction,
        });
        if (padelDto.padelSchedules.length == 0) return padel;
        dayDif =
          moment(possibleToStart).diff(
            moment(padelDto.padelSchedules[0].startTime),
            'days',
          ) + 1;
      } else {
        await this.padelScheduleRepository.destroy({
          where: {
            padelId: padel.id,
            status: { [Op.eq]: 'free' },
          },
        });
        if (padelDto.padelSchedules.length == 0) return padel;
      }
      const ops2 = [];
      padelDto.padelSchedules.forEach((schedule) => {
        for (let i = dayDif; i < 100 + dayDif; i++) {
          ops2.push({
            padelId: padel.id,
            status:
              (schedule.applyForAllDays || i == 0) && schedule.status != null
                ? schedule.status
                : 'free',
            booked:
              schedule.applyForAllDays || i == 0
                ? schedule.booked == null
                  ? false
                  : schedule.booked
                : false,
            price:
              (updatePrice && !isNaN(schedule.price)) ||
              (isNaN(schedule.price) && (schedule.applyForAllDays || i == 0))
                ? padel.price
                : schedule.price,
            startTime: moment(schedule.startTime).add(i, 'days').toDate(),
            endTime: moment(schedule.endTime).add(i, 'days').toDate(),
          });
        }
      });
      await this.padelScheduleRepository.bulkCreate(ops2, {
        transaction: request.transaction,
      });
      // await Promise.all(ops2);
    }
    return padel;
  }

  async findAllOwnersPadels(user: User, query: any): Promise<Padel[]> {
    let startTime = moment().startOf('day').toDate();
    let endTime = moment().endOf('day').toDate();
    if (query.startTime != null && query.startTime != undefined) {
      startTime = moment(query.startTime).startOf('d').toDate();
    }
    if (query.endTime != null && query.endTime != undefined) {
      endTime = moment(query.endTime).endOf('d').toDate();
    }
    return await this.padelsRepository.findAll({
      where: { userId: user.id },
      include: [
        { model: Location },
        { model: Address },
        { model: Duration },
        { model: Feature },
        { model: User },
        {
          model: PadelSchedule,
          required: false,
          where: {
            startTime: { [Op.gte]: startTime },
            endTime: { [Op.lte]: endTime },
          },
        },
      ],
      order: [['id', 'desc']],
    });
  }

  async findAllPromoCodes(user: User): Promise<PromoCode[]> {
    return await this.promoCodeRepository.findAll({
      attributes: { include: [[Sequelize.col('name'), 'PadelName']] },
      include: { model: Padel, required: true, where: { userId: user.id } },
    });
  }

  async findAllFeatures(query: any): Promise<Feature[]> {
    return await this.featuresRepository.findAll({
      limit: Util.getLimit(query),
      offset: Util.getOffset(query),
    });
  }

  async findAllDurations(query: any): Promise<Duration[]> {
    return await this.durationsRepository.findAll({
      limit: Util.getLimit(query),
      offset: Util.getOffset(query),
    });
  }

  async addPromoCode(
    request: any,
    promoCodeDto: PromoCodeDto,
  ): Promise<PromoCode> {
    return await this.promoCodeRepository.create(
      {
        userId: request.user.id,
        padelId: promoCodeDto.padelId,
        code: promoCodeDto.code,
        discount: promoCodeDto.discount,
        maxBooking: Number(promoCodeDto.maxBooking),
        leftForBooking: Number(promoCodeDto.maxBooking),
      },
      { transaction: request.transaction },
    );
  }

  async getPromoCode(request: any): Promise<PromoCode> {
    if (request.query.padelId == undefined || request.query.code == undefined)
      throw Error('Invalid Promo Code');
    const result = await this.promoCodeRepository.findOne({
      where: {
        code: request.query.code,
        padelId: request.query.padelId,
      },
      include: [Padel],
    });
    if (result == null || result.leftForBooking <= 0)
      throw Error('Invalid Promo Code!');
    return result;
  }

  async editPromoCode(
    request: any,
    promoCodeDto: PromoCodeDto,
  ): Promise<PromoCode> {
    const promo = await this.promoCodeRepository.findByPk(promoCodeDto.id, {
      include: { model: Padel, where: { userId: request.user.id } },
    });
    if (promo == null) {
      throw Error(
        'No promo code with id ' +
          promoCodeDto.id +
          ' information found to edit.',
      );
    }
    if (
      (Number(promoCodeDto.maxBooking) != null ||
        Number(promoCodeDto.maxBooking) != undefined) &&
      Number(promoCodeDto.maxBooking) <= promo.leftForBooking
    ) {
      promo.maxBooking =
        Number(promoCodeDto.maxBooking) +
        (promo.maxBooking - promo.leftForBooking);
      promo.leftForBooking = Number(promoCodeDto.maxBooking);
    }
    if (promoCodeDto.code != null && promoCodeDto.code != undefined) {
      promo.code = promoCodeDto.code;
    }
    if (
      promoCodeDto.discount != null &&
      promoCodeDto.discount != undefined &&
      promo.leftForBooking == promo.maxBooking
    ) {
      promo.discount = promoCodeDto.discount;
    }
    return await promo.save({ transaction: request.transaction });
  }

  async editSchedule(
    request: any,
    padelScheduleDto: PadelScheduleDto,
  ): Promise<PadelSchedule> {
    let schedule = await this.padelScheduleRepository.findByPk(
      padelScheduleDto.id,
      { include: Padel },
    );
    if (schedule == null) throw Error('No schedule found with this id!');
    if (schedule.Padel.userId != request.user.id)
      throw Error(
        'Sorry, you are not allowed to change the schedule since your not the owner of this court.',
      );

    if (padelScheduleDto.booked != null) {
      schedule.booked = padelScheduleDto.booked;
      if (schedule.booked && schedule.status == 'free')
        schedule.status = 'reserved';
      if (!schedule.booked && schedule.status == 'reserved')
        schedule.status = 'free';
    }

    if (
      padelScheduleDto.price != null &&
      padelScheduleDto.price != schedule.price
    ) {
      if (
        !schedule.booked ||
        (schedule.booked && schedule.status == 'reserved')
      )
        schedule.price = padelScheduleDto.price;
      else
        throw Error(
          'Sorry, Changing court price while it is booked is no allowed.',
        );
    }

    // if (padelScheduleDto.status != null)
    //   schedule.status = padelScheduleDto.status;

    schedule = await schedule.save({ transaction: request.transaction });

    if (
      padelScheduleDto.applyForAllDays != null &&
      padelScheduleDto.applyForAllDays
    ) {
      const hour = moment(schedule.startTime).hours();
      const minute = moment(schedule.startTime).minutes();
      // const hour = moment(schedule.startTime).subtract(3, 'hours').hours();
      // const minute = moment(schedule.startTime).subtract(3, 'hours').minutes();

      const result = await this.padelScheduleRepository.update(
        {
          price: schedule.price,
          booked: schedule.booked,
          status: schedule.status,
        },
        {
          transaction: request.transaction,
          where: {
            [Op.and]: [
              this.sequelize.where(
                this.sequelize.literal('HOUR(startTime)'),
                '=',
                hour,
              ),
              this.sequelize.where(
                this.sequelize.literal('MINUTE(startTime)'),
                '=',
                minute,
              ),
              this.sequelize.where(
                this.sequelize.literal('padelId'),
                '=',
                schedule.padelId,
              ),
              this.sequelize.where(
                this.sequelize.literal('status'),
                '!=',
                'booked',
              ),
            ],
          },
        },
      );
      console.log(result);
    }

    return schedule;
  }

  async countPadels(startTime: Date, endTime: Date): Promise<number> {
    return await this.padelsRepository.count({
      where: {
        createdAt: {
          [Op.and]: [{ [Op.gte]: startTime }, { [Op.lte]: endTime }],
        },
      },
    });
  }

  async getAllHours(startTime: Date, endTime: Date): Promise<number> {
    const result = await this.padelScheduleRepository.findAll({
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
          'AllHours',
        ],
      ],
      where: {
        startTime: { [Op.gte]: startTime },
        endTime: { [Op.lte]: endTime },
      },
      raw: true,
    });

    return result[0]['AllHours'] || 0;
  }

  async findAllAdminPadels(query: any): Promise<Padel[]> {
    return await this.padelsRepository.findAll({
      where: {
        name: {
          [Op.like]:
            query.search != undefined && query.search != null
              ? '%' + query.search + '%'
              : '%%',
        },
        enabled:
          query.enabled != undefined && query.enabled != null
            ? query.enabled == 'true' || query.enabled == true
            : { [Op.or]: [true, false] },
      },
      include: [Location, Address, Duration, User],
      limit: Util.getLimit(query),
      offset: Util.getOffset(query),
    });
  }

  async findAllAdminPadelsInGroup(groupId: number): Promise<Padel[]> {
    return await this.padelsRepository.findAll({
      where: {
        padelGroupId: groupId,
      },
      include: [Location, Address, Duration, User],
      limit: Util.getLimit(null),
      offset: Util.getOffset(null),
    });
  }

  async findAllPadelsForApproval(query: any): Promise<Padel[]> {
    return await this.padelsRepository.findAll({
      where: {
        name: {
          [Op.like]:
            query.search != undefined && query.search != null
              ? '%' + query.search + '%%'
              : '%%',
        },
        // approved:
        //   query.approved != undefined && query.approved != null
        //     ? query.approved == 'true'
        //     : { [Op.or]: [true, false] },
      },
      include: [
        { model: User, include: [] },
        { model: Location },
        { model: Feature },
        { model: Duration },
        { model: Address },
        { model: PadelGroup },
        {
          model: PadelSchedule,
          required: false,
          where: {
            startTime: { [Op.gte]: moment().startOf('day').toDate() },
            endTime: { [Op.lte]: moment().endOf('day').toDate() },
          },
        },
      ],
      order: [['id', 'desc']],
      limit: Util.getLimit(query),
      offset: Util.getOffset(query),
    });
  }

  async countAllPadels(): Promise<number> {
    const result = await this.padelsRepository.findAll({
      attributes: [[Sequelize.fn('count', Sequelize.col('Padel.id')), 'total']],
    });
    return result[0]['total'];
  }
}
