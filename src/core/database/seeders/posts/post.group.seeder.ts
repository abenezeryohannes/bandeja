import { PostGroup } from 'src/modules/posts/domain/entities/post.group.entity';

export class SeedPostGroup {
  async run(): Promise<boolean> {
    const count = Number.parseInt(process.env.SEED_MULTIPLIER);
    const data = [];
    for (let i = 1; i <= 3 * count; i++) {
      data.push({
        name: 'Ad Type' + i,
        icon: process.env.PLACEHOLDER,
        color: process.env.ACCENT_COLOR,
      });
    }
    await PostGroup.bulkCreate(data);
    return true;
  }

  async clean(): Promise<boolean> {
    await PostGroup.drop({ cascade: true });
    return true;
  }
}
