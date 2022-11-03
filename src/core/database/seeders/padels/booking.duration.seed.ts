import { Duration } from '../../../../modules/padels/domain/entities/duration.entity';

export class SeedDuration {
  async run(): Promise<boolean> {
    // const count = Number.parseInt(process.env.SEED_MULTIPLIER);
    const data = [];
    for (let i = 1; i <= 2; i++) {
      data.push({
        minute: i == 1 ? 60 : 90,
      });
    }
    await Duration.bulkCreate(data);
    return true;
  }

  async clean(): Promise<boolean> {
    await Duration.drop({ cascade: true });
    return true;
  }
}
