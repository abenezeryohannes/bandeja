import { Feature } from '../../../../modules/padels/domain/entities/feature.entity';

export class SeedFeature {
  async run(): Promise<boolean> {
    const count = Number.parseInt(process.env.SEED_MULTIPLIER);
    const data = [
      {
        name: 'wifi',
        icon: 'icons/features/wifi.png',
      },
      {
        name: 'AC',
        icon: 'icons/features/ac.png',
      },
      {
        name: 'TV',
        icon: 'icons/features/tv.png',
      },
      {
        name: 'Coffee',
        icon: 'icons/features/coffee.png',
      },
      {
        name: 'Shower',
        icon: 'icons/features/shower.png',
      },
      {
        name: 'AC',
        icon: 'icons/features/ac.png',
      },
      {
        name: 'TV',
        icon: 'icons/features/tv.png',
      },
      {
        name: 'Coffee',
        icon: 'icons/features/coffee.png',
      },
    ];
    // for (let i = 1; i <= 3 * count + 1; i++) {
    //   data.push({
    //     name: 'Padel-Item' + i,
    //     icon: process.env.PLACEHOLDER,
    //   });
    // }
    await Feature.bulkCreate(data);
    return true;
  }

  async clean(): Promise<boolean> {
    await Feature.drop({ cascade: true });
    return true;
  }
}
