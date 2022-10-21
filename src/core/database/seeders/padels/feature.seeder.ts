import { Feature } from "../../../../modules/padels/domain/entities/feature.entity";

export class SeedFeature {
  async run(): Promise<boolean> {
    const count = Number.parseInt(process.env.SEED_MULTIPLIER);
    const data = [];
    for (let i = 1; i <= 3 * count + 1; i++) {
      data.push({
        name: 'Padel-Item' + i,
        icon: process.env.PLACEHOLDER,
      });
    }
    await Feature.bulkCreate(data);
    return true;
  }

  async clean(): Promise<boolean> {
    await Feature.drop({ cascade: true });
    return true;
  }
}
