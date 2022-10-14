import { Inject, Injectable } from '@nestjs/common';
import { ADDRESS_REPOSITORY } from 'src/core/constants';
import { Util } from 'src/core/utils/util';
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
}
