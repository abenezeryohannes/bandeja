import { Inject, Injectable } from '@nestjs/common';
import { ADDRESS_REPOSITORY } from '../../../../core/constants';
import { Util } from '../../../../core/utils/util';
import { Padel } from '../../../padels/domain/entities/padel.entity';
import { AddressDto } from '../../infrastructure/dto/address.dto';
import { AddressEditDto } from '../../infrastructure/dto/address.edit.dto';
import { Address } from '../entities/address.entity';

@Injectable()
export class AddressService {
  constructor(
    @Inject(ADDRESS_REPOSITORY)
    private readonly addressRepository: typeof Address,
  ) {}

  async findOne(id: number): Promise<Address> {
    return await this.addressRepository.findByPk(id);
  }

  async findAll(query: any): Promise<Address[]> {
    return await this.addressRepository.findAll({
      where: { enabled: true },
      limit: Util.getLimit(query),
      offset: Util.getOffset(query),
    });
  }

  async delete(id: number): Promise<boolean> {
    if (id == null) throw Error('No identifier provided to delete!');

    const address = await this.addressRepository.findByPk(id, {
      include: [Padel],
    });

    if (address.Padels != null && address.Padels.length > 0) {
      throw Error(
        "Can't be deleted becouse it is associated with one or more courts!",
      );
    }
    await address.destroy();
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

  async edit(request: any, body: AddressEditDto): Promise<Address> {
    const address = await this.addressRepository.findByPk(body.id);

    if (address == null) throw Error('No feature found with this id!');

    if (body.enabled != null) address.enabled = body.enabled;

    if (body.name != null) address.name = body.name;

    return await address.save({ transaction: request.transaction });
  }

  async store(request: any, body: AddressDto): Promise<Address> {
    const addresses = await this.addressRepository.findOne({
      where: { name: body.name },
    });

    if (addresses != null) throw Error('Address name must be unique!');

    const address = this.addressRepository.build({
      name: body.name,
    });

    if (body.enabled != null) address.enabled = body.enabled;

    return await address.save({ transaction: request.transaction });
  }
}
