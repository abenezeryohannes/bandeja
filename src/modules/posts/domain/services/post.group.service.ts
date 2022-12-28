import { Inject, Injectable } from '@nestjs/common';
import { join } from 'path';
import { POST_GROUP_REPOSITORY } from '../../../../core/constants';
import { Util } from '../../../../core/utils/util';
import { PostGroupDto } from '../../infrastructure/dto/post.group.dto';
import { PostGroupEditDto } from '../../infrastructure/dto/post.group.edit.dto';
import { Post } from '../entities/post.entity';
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

  async delete(id: number): Promise<boolean> {
    if (id == null) throw Error('No identifier provided to delete!');

    const posts = await this.postGroupsRepository.findByPk(id, {
      include: [Post],
    });

    if (posts.Posts != null && posts.Posts.length > 0) {
      throw Error(
        "Can't be deleted becouse it is associated with one or more Ads!",
      );
    }
    await posts.destroy();
    return true;
  }

  async deleteAll(ids: number[]): Promise<any[]> {
    if (ids == null) throw Error('No identifier provided to delete!');
    const ops = [];
    for (let i = 0; i < ids.length; i++) {
      ops.push(this.delete(ids[i]));
    }
    return await Promise.all(ops);
  }

  async edit(request: any, body: PostGroupEditDto): Promise<PostGroup> {
    const postgroup = await this.postGroupsRepository.findByPk(body.id);

    if (postgroup == null)
      throw Error('No Ad Group found with this identifier!');

    if (body.enabled != null) postgroup.enabled = body.enabled;
    if (body.color != null) postgroup.color = body.color;
    if (body.icon != null) postgroup.icon = body.icon;
    if (body.sequence != null) postgroup.sequence = body.sequence;
    if (body.name != null) postgroup.name = body.name;

    //ICON
    if (
      request.files != null &&
      request.files.icon != null &&
      request.files.icon.length > 0
    )
      postgroup.icon = join('public', request.files.icon[0].filename);

    return await postgroup.save({ transaction: request.transaction });
  }

  async store(request: any, body: PostGroupDto): Promise<PostGroup> {
    const postgroups = await this.postGroupsRepository.findOne({
      where: { name: body.name },
    });

    if (postgroups != null) throw Error('Ad group name must be unique!');

    const postgroup = this.postGroupsRepository.build({
      name: body.name,
    });

    if (body.enabled != null) postgroup.enabled = body.enabled;
    if (body.color != null) postgroup.color = body.color;
    if (body.icon != null) postgroup.icon = body.icon;
    if (body.sequence != null) postgroup.sequence = body.sequence;

    //ICON
    if (
      request.files != null &&
      request.files.icon != null &&
      request.files.icon.length > 0
    )
      postgroup.icon = join('public', request.files.icon[0].filename);

    return await postgroup.save({ transaction: request.transaction });
  }
}
