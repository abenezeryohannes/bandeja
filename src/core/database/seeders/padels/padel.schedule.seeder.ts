import { PadelSchedule } from 'src/modules/padels/domain/entities/padel.schedule.entity';
import * as moment from 'moment';

export class SeedSchedule {
  async run(): Promise<boolean> {
    const count = Number.parseInt(process.env.SEED_MULTIPLIER);
    const data = [];
    let padelId = 0;

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
          for (let index = startTime; index.isBefore(endTime); ) {
            if (counting++ % 3 == 0) {
              data.push({
                padelId: padelId,
                status: 'booked',
                booked: true,
                startTime: index.toDate(),
                endTime: index.add(1, 'hours').toDate(),
              });
            } else {
              data.push({
                padelId: padelId,
                booked: false,
                startTime: index.toDate(),
                endTime: index.add(1, 'hours').toDate(),
              });
            }
          }
        }
      }
    }

    await PadelSchedule.bulkCreate(data);
    return true;
  }

  async clean(): Promise<boolean> {
    await PadelSchedule.drop({ cascade: true });
    return true;
  }
}
