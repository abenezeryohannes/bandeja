import { Inject, Injectable } from '@nestjs/common';
import { PADEL_GROUP_REPOSITORY } from 'src/core/constants';
import { Util } from 'src/core/utils/util';
import { PadelGroup } from '../entities/padel.group.entity';

@Injectable()
export class PadelGroupService {
  constructor(
    @Inject(PADEL_GROUP_REPOSITORY)
    private readonly padelGroupsRepository: typeof PadelGroup,
  ) {}

  async findAll(query: any): Promise<PadelGroup[]> {
    return await this.padelGroupsRepository.findAll({
      where: { enabled: true },
      limit: Util.getLimit(query),
      offset: Util.getOffset(query),
    });
  }
}
