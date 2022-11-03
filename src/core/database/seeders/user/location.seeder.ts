import { Location } from '../../../../modules/users/domain/entities/location.entity';

export class SeedLocation {
  async run(): Promise<boolean> {
    const count = Number.parseInt(process.env.SEED_MULTIPLIER);
    const data = [];
    for (let i = 1; i <= 12 * count; i++) {
      data.push({
        latitude: (Math.random() + 1) * 2000,
        longitude: (Math.random() + 1) * 2000,
        address: 'Kuwati main road',
      });
    }
    await Location.bulkCreate(data);
    return true;
  }

  async clean(): Promise<boolean> {
    await Location.drop({ cascade: true });
    return true;
  }
}
