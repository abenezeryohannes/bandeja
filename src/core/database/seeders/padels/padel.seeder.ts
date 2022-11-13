import * as moment from 'moment';
import { Padel } from '../../../../modules/padels/domain/entities/padel.entity';

export class SeedPadel {
  async run(): Promise<boolean> {
    const count = Number.parseInt(process.env.SEED_MULTIPLIER);
    const data = [];
    let attr = 1;
    let imgCount = 0;
    for (let i = count + 1; i <= 2 * count; i++) {
      for (let j = 1; j < 3; j++) {
        data.push({
          userId: i,
          name: 'Padel Title ' + j,
          barCode: 'XXXX-XXXX-XXXX-XXXX',
          banner: 'img\\padel' + ((imgCount++ % 5) + 1) + '.jpg',
          avatar: 'img\\padelavatar' + ((imgCount++ % 5) + 1) + '.jpg',
          addressId: Math.floor(Math.random() * (count * 3) + 1),
          locationId: 6 * count + attr++,
          padelGroupId: Math.floor(Math.random() * (count * 3) + 1),
          durationId: Math.floor(Math.random() * 2 + 1) == 1 ? 1 : 2,
          onlyLadies: false,
          approved: true,
          startTime: moment(new Date()).startOf('day').toDate(),
          endTime: moment(new Date()).startOf('day').add(12, 'hours').toDate(),
          indoor: true,
          price: 20,
        });
      }
    }
    await Padel.bulkCreate(data);
    return true;
  }

  async clean(): Promise<boolean> {
    await Padel.drop({ cascade: true });
    return true;
  }
}
