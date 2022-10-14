import { Notification } from 'src/modules/notifications/domain/entities/notification.entity';

export class SeedNotification {
  async run(): Promise<boolean> {
    const count = Number.parseInt(process.env.SEED_MULTIPLIER);
    const data = [];
    for (let i = 1; i <= 3 * count; i++) {
      for (let j = 1; j <= count * 3; j++) {
        data.push({
          userId: i,
          title: 'Notification Title ' + j,
          desc: 'Motificaton description ' + j,
        });
      }
    }
    await Notification.bulkCreate(data);
    return true;
  }

  async clean(): Promise<boolean> {
    await Notification.drop({ cascade: true });
    return true;
  }
}
