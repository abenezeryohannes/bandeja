import { Payment } from 'src/modules/booking/domain/entities/payment.entity';
export class SeedPayment {
  async run(): Promise<boolean> {
    const count = Number.parseInt(process.env.SEED_MULTIPLIER);
    const data = [];
    for (let i = 0; i <= count; i++) {
      for (let j = 1; j <= 6 * count; j++) {
        data.push({
          userId: i,
          //type: j <= 3 * count ? 'padel' : 'post',
          amount: 20,
        });
      }
    }
    await Payment.bulkCreate(data);
    return true;
  }

  async clean(): Promise<boolean> {
    await Payment.drop({ cascade: true });
    return true;
  }
}
