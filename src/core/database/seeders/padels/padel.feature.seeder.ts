import { PadelFeature } from 'src/modules/padels/domain/entities/padel.feature';

export class SeedPadelFeature {
  async run(): Promise<boolean> {
    const count = Number.parseInt(process.env.SEED_MULTIPLIER);
    const data = [];
    for (let i = 1; i <= 2 * count; i++) {
      for (let j = 1; j <= count; j++) {
        data.push({
          featureId: j, //Math.floor(Math.random() * (3 * count)) + 1,
          padelId: i,
          quantity: Math.floor(Math.random() * 10 + 1),
          free: j % 2 == 0,
        });
      }
    }
    await PadelFeature.bulkCreate(data);
    return true;
  }

  async clean(): Promise<boolean> {
    await PadelFeature.drop({ cascade: true });
    return true;
  }
}
