import * as moment from 'moment';
import { PadelOrder } from '../../../../modules/booking/domain/entities/padel.order.entity';

export class SeedPadelOrder {
  async run(): Promise<boolean> {
    const count = Number.parseInt(process.env.SEED_MULTIPLIER);
    const data = [];
    let padelId = 0;
    let padelScheduleId = 1;

    for (let i = count + 1; i <= 2 * count; i++) {
      for (let j = 1; j < 3; j++) {
        padelId++;
        for (let k = 0; k < 30; k++) {
          const startTime = moment(new Date())
            .add(k, 'days')
            .startOf('day')
            .add(3, 'hours');
          const endTime = moment(new Date())
            .add(k, 'days')
            .startOf('day')
            .add(15, 'hours');
          let counting = 2;
          for (
            let index = startTime;
            index.isBefore(endTime);
            index = index.add(1, 'hours')
          ) {
            if (counting++ % 3 == 0) {
              data.push({
                userId: i - count,
                padelId: padelId,
                amount: Math.random() * 10000 + 100,
                padelScheduleId: padelScheduleId,
                barCode: 'this is barcode ' + padelId,
              });
            }
            padelScheduleId += 1;
          }
        }
      }
    }

    await PadelOrder.bulkCreate(data);
    return true;
  }

  async clean(): Promise<boolean> {
    await PadelOrder.drop({ cascade: true });
    return true;
  }
}
