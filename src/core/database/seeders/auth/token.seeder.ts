import moment from 'moment';
import { Token } from '../../../../modules/auth/domain/entities/token.entity';

export class SeedToken {
  async run(): Promise<boolean> {
    const count = Number.parseInt(process.env.SEED_MULTIPLIER);
    const data = [];
    for (let i = 1; i <= count; i++) {
      data.push({
        userId: i,
        // until: moment().add(12, 'M').toDate(),
        role: 'user',
        token: 'user' + (i == 1 ? '' : i),
      });
    }
    for (let i = count + 1; i <= 2 * count; i++) {
      data.push({
        userId: i,
        //until: moment().add(moment.duration(12, 'months')).toDate(),
        role: 'owner',
        token: 'owner' + (i == count ? '' : i),
      });
    }
    for (let i = 2 * count + 1; i <= 3 * count; i++) {
      data.push({
        userId: i,
        //until: moment().add(moment.duration(12, 'months')).toDate(),
        role: 'admin',
        token: 'admin' + (i == 2 * count ? '' : i),
      });
    }
    await Token.bulkCreate(data);
    return true;
  }

  async clean(): Promise<boolean> {
    await Token.drop({ cascade: true });
    return true;
  }
}
