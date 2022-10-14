import { Inject, Injectable } from '@nestjs/common';
import { POST_GROUP_REPOSITORY } from 'src/core/constants';
import { Util } from 'src/core/utils/util';
import { PostGroup } from '../entities/post.group.entity';

@Injectable()
export class PostGroupService {
  constructor(
    @Inject(POST_GROUP_REPOSITORY)
    private readonly postGroupsRepository: typeof PostGroup,
  ) {}

  async findAll(query): Promise<PostGroup[]> {
    return await this.postGroupsRepository.findAll({
      where: { enabled: true },
      limit: Util.getLimit(query),
      offset: Util.getOffset(query),
    });
  }
}
