import { Inject, Injectable } from '@nestjs/common';
import {
  ADDRESS_REPOSITORY,
  APP_VISIT_REPOSITORY,
  LOCATION_REPOSITORY,
  SETTING_REPOSITORY,
  USER_REPOSITORY,
} from '../../../../core/constants';
import { ROLE, UserDto } from '../../infrastructure/dto/user.dto';
import { Address } from '../entities/address.entity';
import { User } from '../entities/user.entity';
import { Location } from '../entities/location.entity';
import { Op } from 'sequelize';
import { join } from 'path';
import { Token } from '../../../auth/domain/entities/token.entity';
import { Util } from '../../../../core/utils/util';
import { Padel } from '../../../padels/domain/entities/padel.entity';
import { Feature } from '../../../padels/domain/entities/feature.entity';
import { Duration } from '../../../padels/domain/entities/duration.entity';
import { PadelSchedule } from '../../../padels/domain/entities/padel.schedule.entity';
import { FilterPadelDto } from '../../../padels/infrastructure/dto/filter.padel.dto';
import { UserEditDto } from '../../infrastructure/dto/user.edit.dto';
import { Setting } from '../entities/setting.entity';
import { LocationDto } from '../../infrastructure/dto/location.dto';
import { AppVisit } from '../entities/app.visit.entity';
import * as moment from 'moment';
import { isNumber } from 'class-validator';

@Injectable()
export class UsersService {
  constructor(
    @Inject(USER_REPOSITORY) private readonly userRepository: typeof User,
    @Inject(ADDRESS_REPOSITORY)
    private readonly addressRepository: typeof Address,
    @Inject(LOCATION_REPOSITORY)
    private readonly locationRepository: typeof Location,
    @Inject(APP_VISIT_REPOSITORY)
    private readonly appVisitRepository: typeof AppVisit,
    @Inject(SETTING_REPOSITORY)
    private readonly settingRepository: typeof Setting,
  ) {}

  async edit(request: any, userDto: UserEditDto): Promise<User> {
    let user = await this.userRepository.findByPk(request.user.id);
    if (request.user.role != ROLE.ADMIN && request.user.id != user.id) {
      throw Error('Sorry, you are not authorized to make this change!');
    }
    if (userDto.fullName != null && userDto.fullName.length > 0)
      user.setDataValue('fullName', userDto.fullName);

    if (userDto.phoneNumber != null && userDto.phoneNumber.length > 0)
      user.setDataValue('phoneNumber', userDto.phoneNumber);

    if (userDto.emailAddress != null && userDto.emailAddress.length > 0)
      user.setDataValue('emailAddress', userDto.emailAddress);

    if (userDto.Location != null) {
      const location =
        user.locationId != null
          ? await this.locationRepository.findByPk(user.locationId)
          : await this.locationRepository.create({});
      user.locationId = location.id;
      location.address = userDto.Location.address;
      location.latitude = userDto.Location.latitude;
      location.longitude = userDto.Location.longitude;
      await location.save();
    }
    if (userDto.Location != null) {
      let location = await Location.findOne({ where: { userId: user.id } });
      if (location == null) location = Location.build({ userId: user.id });
      location.latitude = userDto.Location.latitude;
      location.longitude = userDto.Location.longitude;
      location = await location.save();
    }

    if (userDto.password != null && userDto.password.length > 0)
      user.setDataValue('password', userDto.password);

    if (userDto.enabled != null) user.setDataValue('enabled', userDto.enabled);

    if (request.file != null)
      user.setDataValue('avatar', join('public', request.file.filename));

    let setting = await this.settingRepository.findOne({
      where: { userId: user.id },
    });

    if (setting == null)
      setting = await this.settingRepository.build({ userId: user.id });

    if (userDto.bookingNotification != null)
      setting.setDataValue('bookingNotification', userDto.bookingNotification);

    if (userDto.faceId != null) setting.setDataValue('faceId', userDto.faceId);

    setting = await setting.save({ transaction: request.transaction });
    user = await user.save({ transaction: request.transaction });
    user.Setting = setting;
    return user;
  }

  async create(user: UserDto, transaction: any): Promise<User> {
    const userExist = await this.userRepository.findOne({
      where: { phoneNumber: user.phoneNumber, UID: user.UID },
    });
    if (userExist != null) return userExist;
    let result = await this.userRepository.create<User>(
      { ...user },
      { transaction: transaction },
    );
    if (
      user.Location != null &&
      isNumber(user.Location.latitude) &&
      isNumber(user.Location.longitude)
    ) {
      const location = await this.locationRepository.create<Location>(
        {
          latitude: user.Location.latitude,
          longitude: user.Location.longitude,
          address: user.Location.address,
        },
        { transaction: transaction },
      );
      result.locationId = location.id;
    }
    result = await result.save();
    const setting = await this.settingRepository.create<Setting>({
      userId: result.id,
    });
    result.Setting = setting;
    return result;
  }

  async addLocation(dto: LocationDto): Promise<Location> {
    if (dto == null) dto = new LocationDto(-1, 0, 0, '');
    return await this.locationRepository.create({
      latitude: dto.latitude,
      longitude: dto.longitude,
      address: dto.address,
    });
  }
  async editLocation(dto: LocationDto): Promise<Location> {
    const location = await this.locationRepository.findByPk(dto.id);
    location.latitude = dto.latitude;
    location.longitude = dto.longitude;
    location.address = dto.address;
    return await location.save();
  }

  async findOneByPhoneNumber(phoneNumber: string): Promise<User> {
    return await this.userRepository.findOne<User>({
      where: { phoneNumber: phoneNumber },
      include: [{ model: Token }, { model: Setting }],
    });
  }

  async findOneByEmail(emailAddress: string): Promise<User> {
    return await this.userRepository.findOne<User>({
      where: { emailAddress: emailAddress },
      include: [{ model: Token }, { model: Setting }],
    });
  }

  async findOneById(id: number): Promise<User> {
    return await this.userRepository.findByPk<User>(id, {
      include: [Token, Address, Location, { model: Setting }],
    });
  }

  async findUserWithToken(id: number, token: string): Promise<User> {
    return await this.userRepository.findByPk<User>(id, {
      include: [{ model: Token }, { model: Setting }],
    });
  }

  async bookmarks(user: User, query: any): Promise<Padel[]> {
    const result = await this.userRepository.findByPk(user.id, {
      include: [{ model: Padel, include: [User, Location, Address, Feature] }],
      limit: Util.getLimit(query),
      offset: Util.getOffset(query),
    });
    return result['Bookmarks'];
  }

  async findAllOwnerAndAdmins(request: any): Promise<User[]> {
    return await this.userRepository.findAll({
      where: { role: { [Op.or]: [ROLE.ADMIN, ROLE.OWNER] } },
      limit: Util.getLimit(request.query),
      offset: Util.getOffset(request.query),
    });
  }

  async visitStart(request: any): Promise<AppVisit> {
    return await AppVisit.create({
      userId: request.user.id,
      startTime: moment().toDate(),
      endTime: moment().add(1, 'minutes').toDate(),
    });
  }

  async visitEnd(request: any): Promise<AppVisit> {
    let pastVisit = await this.appVisitRepository.findOne({
      where: { userId: request.user.id },
    });
    if (pastVisit == null) pastVisit = await this.visitStart(request);
    pastVisit.endTime = moment().toDate();
    return await pastVisit.save();
  }

  async countAppVisits(startTime: Date, endTime: Date): Promise<number> {
    return await this.appVisitRepository.count({
      where: {
        [Op.or]: [
          { startTime: { [Op.gte]: startTime } },
          { endTime: { [Op.lte]: endTime } },
        ],
      },
    });
  }

  async countUsers(startTime: Date, endTime: Date): Promise<number> {
    return await this.userRepository.count({
      where: {
        createdAt: {
          [Op.and]: [{ [Op.gte]: startTime }, { [Op.lte]: endTime }],
        },
      },
    });
  }

  async findAllUserIds(role: string): Promise<number[]> {
    const userIds = await this.userRepository.findAll({
      attributes: [['id', 'id']],
      where: {
        role: role == null || role == undefined ? { [Op.ne]: null } : role,
      },
    });
    return userIds.map((e) => e['id']);
  }

  async filterPadels(
    startTime: Date,
    endTime: Date,
    filterPadelDto: FilterPadelDto,
  ): Promise<User[]> {
    const conditions = { enabled: true };
    if (filterPadelDto.addressId != null) {
      conditions['addressId'] = filterPadelDto.addressId;
    }
    if (filterPadelDto.padelGroupId != null) {
      conditions['padelGroupId'] = filterPadelDto.padelGroupId;
    }
    return await this.userRepository.findAll({
      where: { role: ROLE.OWNER, enabled: true },
      include: {
        model: Padel,
        as: 'Padels',
        required: true,
        // where: conditions,
        include: [
          { model: Location },
          { model: Address },
          { model: Duration },
          { model: Feature },
          { model: User },
          {
            model: PadelSchedule,
            required: true,
            where: {
              startTime: { [Op.gte]: startTime },
              endTime: { [Op.lte]: endTime },
              booked: false,
            },
          },
        ],
      },
    });
  }
}
