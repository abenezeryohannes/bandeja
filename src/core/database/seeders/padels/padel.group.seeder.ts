import { PadelGroup } from "../../../../modules/padels/domain/entities/padel.group.entity";

export class SeedPadelGroup {
  async run(): Promise<boolean> {
    const count = Number.parseInt(process.env.SEED_MULTIPLIER);
    const data = [];
    for (let i = 1; i <= 3 * count; i++) {
      data.push({
        name: 'Padel Type' + i,
        icon: process.env.PLACEHOLDER,
        color: process.env.ACCENT_COLOR,
      });
    }
    await PadelGroup.bulkCreate(data);
    return true;
  }

  async clean(): Promise<boolean> {
    await PadelGroup.drop({ cascade: true });
    return true;
  }
}
