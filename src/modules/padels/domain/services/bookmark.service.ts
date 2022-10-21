import { Inject, Injectable } from '@nestjs/common';
import { Bookmark } from '../../../padels/domain/entities/bookmark.entity';
import { Feature } from '../entities/feature.entity';
import { Padel } from '../entities/padel.entity';
import { BookmarkDto } from '../../infrastructure/dto/bookmark.dto';
import { PadelSchedule } from '../entities/padel.schedule.entity';
import { Op } from 'sequelize';
import * as moment from 'moment';
import { BOOKMARK_REPOSITORY } from '../../../../core/constants';
import { User } from '../../../users/domain/entities/user.entity';
import { Location } from '../../../users/domain/entities/location.entity';
import { Address } from '../../../users/domain/entities/address.entity';
import { Util } from '../../../../core/utils/util';

@Injectable()
export class BookmarkService {
  constructor(
    @Inject(BOOKMARK_REPOSITORY)
    private readonly bookmarkRepository: typeof Bookmark,
  ) {}

  findOne(id: number) {
    throw new Error('Method not implemented.');
  }
  async findAll(user: User, query: any): Promise<Bookmark[]> {
    const startTime = moment().startOf('day').toDate();
    const endTime = moment().endOf('day').toDate();

    const bookmarks = await this.bookmarkRepository.findAll({
      where: { userId: user.id },
      include: {
        model: Padel,
        include: [
          { model: User },
          { model: Location },
          {
            model: PadelSchedule,
            required: true,
            where: {
              startTime: { [Op.gte]: startTime },
              endTime: { [Op.lte]: endTime },
              // booked: false,
            },
          },
          { model: Address },
          { model: Feature },
          { model: Bookmark, where: { userId: user.id }, required: true },
        ],
      },

      limit: Util.getLimit(query),
      offset: Util.getOffset(query),
    });
    return bookmarks.map((e) => e.getDataValue('Padel'));
    //return await this.userService.bookmarks(user, query);
  }

  async set(user: User, bookmarkDto: BookmarkDto): Promise<boolean> {
    const bookmark = await this.bookmarkRepository.findOne({
      where: {
        userId: user.id,
        padelId: bookmarkDto.padelId,
      },
    });
    if (bookmark == null) {
      await this.bookmarkRepository.create({
        userId: user.id,
        padelId: bookmarkDto.padelId,
      });
      return true;
    } else {
      await bookmark.destroy();
      return true;
    }
  }
}
