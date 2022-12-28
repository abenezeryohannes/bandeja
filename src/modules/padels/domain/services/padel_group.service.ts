import { Inject, Injectable } from '@nestjs/common';
import { join } from 'path';
import { PADEL_GROUP_REPOSITORY } from '../../../../core/constants';
import { Util } from '../../../../core/utils/util';
import { PadelGroupDto } from '../../infrastructure/dto/padel.group.dto';
import { PadelGroupEditDto } from '../../infrastructure/dto/padel.group.edit';
import { Padel } from '../entities/padel.entity';
import { PadelGroup } from '../entities/padel.group.entity';
import { PadelsService } from './padels.service';

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
  async findAllForAdmin(query: any): Promise<PadelGroup[]> {
    return await this.padelGroupsRepository.findAll({
      order: [['sequence', 'asc']],
      limit: Util.getLimit(query),
      offset: Util.getOffset(query),
    });
  }

  async findOneByName(name: string): Promise<PadelGroup> {
    return await this.padelGroupsRepository.findOne({
      where: { name: name, enabled: true },
    });
  }

  async edit(request: any, body: PadelGroupEditDto): Promise<PadelGroup> {
    const group = await this.padelGroupsRepository.findByPk(body.id);

    //  console.log('group: ', group.toJSON());
    if (group == null) throw Error('No padel found with this id!');

    if (body.color != null) group.color = body.color;

    if (body.enabled != null) group.enabled = body.enabled;

    if (body.sequence != null) group.sequence = body.sequence;

    if (body.icon != null) group.icon = body.icon;

    if (body.name != null) group.name = body.name;

    //ICON
    if (
      request.files != null &&
      request.files.icon != null &&
      request.files.icon.length > 0
    )
      group.icon = join('public', request.files.icon[0].filename);

    return await group.save({ transaction: request.transaction });
  }

  async delete(id: number): Promise<boolean> {
    if (id == null) throw Error('No identifier provided to delete!');

    const group = await this.padelGroupsRepository.findByPk(id, {
      include: Padel,
    });

    if (group.Padels != null && group.Padels.length > 0) {
      throw Error("Can't be deleted becouse it holds one or more courts!");
    }
    await group.destroy();
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

  async store(request: any, body: PadelGroupDto): Promise<PadelGroup> {
    const padelgroups = await this.padelGroupsRepository.findOne({
      where: { name: body.name },
    });

    if (padelgroups != null) throw Error('Court Group name must be unique!');

    const padelgroup = this.padelGroupsRepository.build({
      name: body.name,
    });

    if (body.enabled != null) padelgroup.enabled = body.enabled;
    if (body.color != null) padelgroup.color = body.color;
    if (body.icon != null) padelgroup.icon = body.icon;
    if (body.sequence != null) padelgroup.sequence = body.sequence;

    //ICON
    if (
      request.files != null &&
      request.files.icon != null &&
      request.files.icon.length > 0
    )
      padelgroup.icon = join('public', request.files.icon[0].filename);

    return await padelgroup.save({ transaction: request.transaction });
  }
}
