import { Inject, Injectable } from '@nestjs/common';
import { BOOKMARK_REPOSITORY } from 'src/core/constants';
import { Util } from 'src/core/utils/util';
import { Address } from 'src/modules/users/domain/entities/address.entity';
import { User } from 'src/modules/users/domain/entities/user.entity';
import { Location } from 'src/modules/users/domain/entities/location.entity';
import { Bookmark } from '../../../padels/domain/entities/bookmark.entity';
import { Feature } from '../entities/feature.entity';
import { Padel } from '../entities/padel.entity';
import { BookmarkDto } from '../../infrastructure/dto/bookmark.dto';

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
    return await this.bookmarkRepository.findAll({
      where: { userId: user.id },
      include: [{ model: Padel, include: [User, Location, Address, Feature] }],
      limit: Util.getLimit(query),
      offset: Util.getOffset(query),
    });
    //return await this.userService.bookmarks(user, query);
  }

  async set(user: User, bookmarkDto: BookmarkDto): Promise<Bookmark> {
    const bookmark = await this.bookmarkRepository.findOne({
      where: {
        userId: user.id,
        padelId: bookmarkDto.id,
      },
    });
    if (bookmark == null) {
      return await this.bookmarkRepository.create({
        userId: user.id,
        padelId: bookmarkDto.id,
      });
    } else {
      await bookmark.destroy();
      return bookmark;
    }
  }
}
