import { Post } from 'src/modules/posts/domain/entities/post.entity';

export class SeedPost {
  async run(): Promise<boolean> {
    const count = Number.parseInt(process.env.SEED_MULTIPLIER);
    const data = [];
    // let attr = 1;
    for (let i = 1; i <= count; i++) {
      for (let j = 1; j <= 3; j++) {
        data.push({
          userId: i,
          postGroupId: Math.floor(Math.random() * (count * 3) + 1),
          quantity: Math.random() * 100 + 1,
          desc: 'lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum',
          padelGroupId: Math.floor(Math.random() * (count * 3) + 1),
          featured: true,
          offer: Math.floor(Math.random() * 2) + 1 == 1 ? true : false,
          price: 20,
        });
      }
    }
    await Post.bulkCreate(data);
    return true;
  }

  async clean(): Promise<boolean> {
    await Post.drop({ cascade: true });
    return true;
  }
}
