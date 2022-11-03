import { User } from '../../../../modules/users/domain/entities/user.entity';

export class SeedUser {
  async run(): Promise<boolean> {
    const count = Number.parseInt(process.env.SEED_MULTIPLIER);
    const data = [];
    for (let i = 1; i <= count; i++) {
      data.push({
        fullName: 'user' + i,
        avatar: process.env.USER_IMG_PLACEHOLDER,
        UID: (Math.random() + 1).toString(36).substring(7),
        role: 'user',
        locationId: i,
        phoneNumber: '+2519' + (Math.random() + 10000000) * 100000000,
      });
    }
    for (let i = count + 1; i <= 2 * count; i++) {
      data.push({
        fullName: 'owner' + i,
        avatar: process.env.USER_IMG_PLACEHOLDER,
        UID: (Math.random() + 1).toString(36).substring(7),
        role: 'owner',
        locationId: i,
        phoneNumber: '+2519' + (Math.random() + 10000000) * 100000000,
        emailAddress: 'owner@example.com',
        password: 1234,
      });
    }
    for (let i = 2 * count + 1; i <= 3 * count; i++) {
      data.push({
        fullName: 'admin' + i,
        avatar: process.env.USER_IMG_PLACEHOLDER,
        UID: (Math.random() + 1).toString(36).substring(7),
        role: 'admin',
        locationId: i,
        phoneNumber: '+2519' + (Math.random() + 10000000) * 100000000,
        emailAddress: 'admin@example.com',
        password: 1234,
      });
    }
    await User.bulkCreate(data);
    return true;
  }

  async clean(): Promise<boolean> {
    await User.drop({ cascade: true });
    return true;
  }
}
