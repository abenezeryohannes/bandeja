import { Setting } from '../../../../modules/users/domain/entities/setting.entity';

export class SeedSetting {
  async run(): Promise<boolean> {
    const count = Number.parseInt(process.env.SEED_MULTIPLIER);
    const data = [];
    let attr = 1;
    for (let i = 1; i <= count; i++) {
      data.push({
        userId: attr++,
      });
    }
    for (let i = count + 1; i <= 2 * count; i++) {
      data.push({
        userId: attr++,
      });
    }
    for (let i = 2 * count + 1; i <= 3 * count; i++) {
      data.push({
        userId: attr++,
      });
    }
    await Setting.bulkCreate(data);
    return true;
  }

  async clean(): Promise<boolean> {
    await Setting.drop({ cascade: true });
    return true;
  }
}
