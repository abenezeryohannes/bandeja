import { Inject, Injectable } from '@nestjs/common';
import { join } from 'path';
import { ADS_REPOSITORY } from '../../../../core/constants';
import { Util } from '../../../../core/utils/util';
import { User } from '../../../users/domain/entities/user.entity';
import { AdDto } from '../../infrastructure/ad.dto';
import { AdEditDto } from '../../infrastructure/ad.edit.dto';
import { Ad } from '../entities/ad.entity';

@Injectable()
export class AdsService {
  constructor(
    @Inject(ADS_REPOSITORY)
    private readonly adRepository: typeof Ad,
  ) {}

  async findAll(query: any): Promise<Ad[]> {
    const condition = { enabled: true };

    return this.adRepository.findAll({
      where: condition,
      include: [User],
      limit: Util.getLimit(query),
      offset: Util.getOffset(query),
      order: [['id', 'DESC']],
    });
  }

  async create(request: any, adDto: AdDto): Promise<Ad> {
    let ad = this.adRepository.build({
      userId: request.user.id,
      link: adDto.link,
      enabled: adDto.enabled,
    });
    if (adDto.enabled != null) ad.enabled = adDto.enabled;

    ad = await ad.save({ transaction: request.transaction });
    if (request.file != null && request.file.length > 0)
      ad.banner = join('public', request.file[0].filename);
    return ad;
  }

  async edit(request: any, body: AdEditDto): Promise<Ad> {
    const ad = await this.adRepository.findByPk(body.id);

    if (ad == null) throw Error('No Ad found with this id!');

    if (body.enabled != null) ad.enabled = body.enabled;
    if (body.link != null) ad.link = body.link;

    if (request.file != null && request.file.length > 0)
      ad.banner = join('public', request.file[0].filename);

    const ops = [];
    await Promise.all(ops);

    return await ad.save({ transaction: request.transaction });
  }

  async delete(id: number): Promise<boolean> {
    if (id == null) throw Error('No identifier provided to delete!');
    const ad = await this.adRepository.findByPk(id);
    await ad.destroy();
    return true;
  }
}
