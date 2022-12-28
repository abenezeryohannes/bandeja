import { Ad } from '../../../../modules/ads/domain/entities/ad.entity';

export class SeedAd {
  async run(): Promise<boolean> {
    const count = Number.parseInt(process.env.SEED_MULTIPLIER);
    const data = [];
    let attr = 1;
    for (let i = 1; i <= count; i++) {
      for (let j = 1; j <= 3; j++) {
        data.push({
          userId: i,
          banner: 'img/post' + attr++ + '.jpg',
          link: 'https://www.google.com',
          enabled: true,
        });
      }
    }
    await Ad.bulkCreate(data);
    return true;
  }

  async clean(): Promise<boolean> {
    await Ad.drop({ cascade: true });
    return true;
  }
}
