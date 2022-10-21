import { Bookmark } from "../../../../modules/padels/domain/entities/bookmark.entity";

export class SeedBookmark {
  async run(): Promise<boolean> {
    const count = Number.parseInt(process.env.SEED_MULTIPLIER);
    const data = [];
    for (let i = 1; i <= count; i++) {
      for (let j = 1; j <= count * 2; j++) {
        data.push({
          userId: i,
          padelId: j,
        });
      }
    }
    await Bookmark.bulkCreate(data);
    return true;
  }

  async clean(): Promise<boolean> {
    await Bookmark.drop({ cascade: true });
    return true;
  }
}
