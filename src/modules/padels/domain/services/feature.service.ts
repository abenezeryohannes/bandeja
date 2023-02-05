import { Inject, Injectable } from '@nestjs/common';
import { join } from 'path';
import { FEATURE_REPOSITORY } from '../../../../core/constants';
import { Util } from '../../../../core/utils/util';
import { FeatureDto } from '../../infrastructure/dto/feature.dto';
import { FeatureEditDto } from '../../infrastructure/dto/feature.edit.dto';
import { Feature } from '../entities/feature.entity';
import { Padel } from '../entities/padel.entity';
import { PadelFeature } from '../entities/padel.feature';

@Injectable()
export class FeatureService {
  constructor(
    @Inject(FEATURE_REPOSITORY)
    private readonly FeaturesRepository: typeof Feature,
  ) {}

  async delete(id: number): Promise<boolean> {
    if (id == null) throw Error('No identifier provided to delete!');

    const feature = await this.FeaturesRepository.findByPk(id, {
      include: Padel,
    });

    if (feature.Padels != null && feature.Padels.length > 0) {
      throw Error(
        "Can't be deleted becouse it is associated with one or more courts!",
      );
    }
    await feature.destroy();
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

  async findAll(query: any): Promise<Feature[]> {
    return await this.FeaturesRepository.findAll({
      limit: Util.getLimit(query),
      offset: Util.getOffset(query),
    });
  }

  async edit(request: any, body: FeatureEditDto): Promise<Feature> {
    const feature = await this.FeaturesRepository.findByPk(body.id);

    if (feature == null) throw Error('No feature found with this id!');

    if (body.enabled != null) feature.enabled = body.enabled;

    if (body.icon != null) feature.icon = body.icon;

    if (body.name != null) feature.name = body.name;

    //ICON
    if (
      request.files != null &&
      request.files.icon != null &&
      request.files.icon.length > 0
    )
      feature.icon = join('public', request.files.icon[0].filename);

    return await feature.save({ transaction: request.transaction });
  }

  async store(request: any, body: FeatureDto): Promise<Feature> {
    const features = await this.FeaturesRepository.findOne({
      where: { name: body.name },
    });

    if (features != null) throw Error('Feature name must be unique!');

    const feature = this.FeaturesRepository.build({
      name: body.name,
      icon: body.icon,
    });

    if (body.enabled != null) feature.enabled = body.enabled;
    //ICON
    if (
      request.files != null &&
      request.files.icon != null &&
      request.files.icon.length > 0
    )
      feature.icon = join('public', request.files.icon[0].filename);

    return await feature.save({ transaction: request.transaction });
  }
}
