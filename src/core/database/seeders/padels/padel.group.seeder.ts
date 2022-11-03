import { PadelGroup } from '../../../../modules/padels/domain/entities/padel.group.entity';

export class SeedPadelGroup {
  async run(): Promise<boolean> {
    const count = Number.parseInt(process.env.SEED_MULTIPLIER);
    const data = [
      {
        name: 'Indoor',
        icon: 'icons/indoor.png',
      },
      {
        name: 'Outdoor',
        icon: 'icons/outdoor.png',
      },
      {
        name: 'Ladies',
        icon: 'icons/ladies.png',
      },
      {
        name: 'Offer',
        icon: 'icons/offers.png',
      },
    ];
    // for (let i = 1; i <= 3 * count; i++) {
    //   data.push({
    //     name: 'Indoor' + i,
    //     icon: process.env.PLACEHOLDER,
    //     color: process.env.ACCENT_COLOR,
    //   });
    // }
    await PadelGroup.bulkCreate(data);
    return true;
  }

  async clean(): Promise<boolean> {
    await PadelGroup.drop({ cascade: true });
    return true;
  }
}
