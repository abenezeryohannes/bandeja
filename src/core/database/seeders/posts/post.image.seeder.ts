import { PostImage } from '../../../../modules/posts/domain/entities/post.image.entity';

export class SeedPostImage {
  async run(): Promise<boolean> {
    const count = Number.parseInt(process.env.SEED_MULTIPLIER);
    const data = [];
    let attr = 1;
    for (let i = 1; i <= count; i++) {
      for (let j = 1; j <= 3; j++) {
        data.push({
          postId: i - 1 + j,
          img: 'img/post' + attr++ + '.jpg',
        });
      }
    }
    await PostImage.bulkCreate(data);
    return true;
  }

  async clean(): Promise<boolean> {
    await PostImage.drop({ cascade: true });
    return true;
  }
}
