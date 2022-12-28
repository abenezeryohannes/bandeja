import { Address } from '../../../../modules/users/domain/entities/address.entity';

export class SeedAddress {
  async run(): Promise<boolean> {
    const count = Number.parseInt(process.env.SEED_MULTIPLIER);
    const data = [];
    for (let i = 1; i <= 3 * count; i++) {
      data.push({
        name: 'place' + i,
      });
    }
    await Address.bulkCreate(data);
    return true;
  }

  async clean(): Promise<boolean> {
    await Address.drop({ cascade: true });
    return true;
  }
}
