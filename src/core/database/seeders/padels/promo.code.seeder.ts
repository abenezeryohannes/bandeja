import { PromoCode } from '../../../../modules/padels/domain/entities/promo.code.entity';

export class SeedPromoCode {
  async run(): Promise<boolean> {
    const count = Number.parseInt(process.env.SEED_MULTIPLIER);
    const data = [];
    let attr = 1;
    for (let i = 1; i <= count; i++) {
      for (let j = 1; j <= 2; j++) {
        data.push({
          user_id: i + count,
          code: Math.round(Math.random() * 10000 + 1),
          padelId: attr++,
          maxBooking: 20,
          leftForBooking: 20,
          discount: 20,
        });
      }
    }
    await PromoCode.bulkCreate(data);
    return true;
  }

  async clean(): Promise<boolean> {
    await PromoCode.drop({ cascade: true });
    return true;
  }
}
