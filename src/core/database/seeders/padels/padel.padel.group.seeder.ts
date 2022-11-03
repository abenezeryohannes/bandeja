import { PadelPadelGroup } from '../../../../modules/padels/domain/entities/padel.padel.group';

export class SeedPadelPadelGroup {
  async run(): Promise<boolean> {
    const count = Number.parseInt(process.env.SEED_MULTIPLIER);
    const data = [];
    let attr = 1;
    for (let i = count + 1; i <= 2 * count; i++) {
      for (let j = 1; j < 3; j++) {
        data.push({
          padelId: attr++,
          padelGroupId: Math.floor(Math.random() * count + 1),
        });
      }
    }
    await PadelPadelGroup.bulkCreate(data);
    return true;
  }

  async clean(): Promise<boolean> {
    await PadelPadelGroup.drop({ cascade: true });
    return true;
  }
}
