import { Inject, Injectable } from '@nestjs/common';
import { PADEL_GROUP_REPOSITORY } from '../../../../core/constants';
import { Util } from '../../../../core/utils/util';
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

  async findOneByName(name: string): Promise<PadelGroup> {
    return await this.padelGroupsRepository.findOne({
      where: { name: name, enabled: true },
    });
  }
}
