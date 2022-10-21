import { Inject, Injectable } from '@nestjs/common';
import {
  ADDRESS_REPOSITORY,
  LOCATION_REPOSITORY,
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

@Injectable()
export class UsersService {
  constructor(
    @Inject(USER_REPOSITORY) private readonly userRepository: typeof User,
    @Inject(ADDRESS_REPOSITORY)
    private readonly addressRepository: typeof Address,
    @Inject(LOCATION_REPOSITORY)
    private readonly locationRepository: typeof Location,
  ) {}

  async edit(request: any, userDto: UserDto): Promise<User> {
    const user = await this.userRepository.findByPk(request.user.id);

    if (userDto.fullName != null && userDto.fullName.length > 0)
      user.setDataValue('fullName', userDto.fullName);

    if (userDto.phoneNumber != null && userDto.phoneNumber.length > 0)
      user.setDataValue('phoneNumber', userDto.phoneNumber);

    if (request.file != null)
      user.setDataValue('avatar', join('public', request.file.filename));

    return await user.save();
  }

  async create(user: UserDto, transaction: any): Promise<User> {
    const userExist = await this.userRepository.findOne({
      where: { phoneNumber: user.phoneNumber, UID: user.UID },
    });
    if (userExist != null) return userExist;
    return await this.userRepository.create<User>(
      { ...user },
      { transaction: transaction },
    );
  }

  async findOneByPhoneNumber(phoneNumber: string): Promise<User> {
    return await this.userRepository.findOne<User>({
      where: { phoneNumber },
      include: [{ model: Token }],
    });
  }

  async findOneById(id: number): Promise<User> {
    return await this.userRepository.findByPk<User>(id, {
      include: [Token, Address, Location],
    });
  }

  async findUserWithToken(id: number, token: string): Promise<User> {
    return await this.userRepository.findByPk<User>(id, {
      include: [{ model: Token }],
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

  async filterOwnersPadel(
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
        where: conditions,
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
              // booked: false,
            },
          },
        ],
      },
    });
  }
}
