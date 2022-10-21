import { AllowedBookingHour } from "../../../../modules/padels/domain/entities/allowed.booking.hour.entity";

export class SeedAllowedBookingHour {
  async run(): Promise<boolean> {
    const count = Number.parseInt(process.env.SEED_MULTIPLIER);
    const data = [];
    for (let i = count + 1; i <= 2 * count; i++) {
      for (let j = 1; j < 3; j++) {
        data.push({
          padelId: i + j - 1,
          hour: i + j,
          am: true,
        });
      }
    }
    await AllowedBookingHour.bulkCreate(data);
    return true;
  }

  async clean(): Promise<boolean> {
    await AllowedBookingHour.drop({ cascade: true });
    return true;
  }
}
