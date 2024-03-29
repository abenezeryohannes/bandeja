import { SeedNotification } from './notifications/notification.seeder';
import { SeedPost } from './posts/post.seeder';
import { SeedPadel } from './padels/padel.seeder';
import { SeedPostImage } from './posts/post.image.seeder';
import { SeedPostGroup } from './posts/post.group.seeder';
import { SeedFeature } from './padels/feature.seeder';
import { SeedPadelGroup } from './padels/padel.group.seeder';
import { SeedBookmark } from './padels/bookmark.seeder';
import { SeedLocation } from './user/location.seeder';
import { SeedUser } from './user/user.seeder';
import { SeedToken } from './auth/token.seeder';
import { SeedAddress } from './user/address.seeder';
import { SeedPayment } from './booking/payment.seeder';
import { SeedPadelOrder } from './booking/order.padel.seeder';
import { SeedPadelFeature } from './padels/padel.feature.seeder';
import { SeedAllowedBookingHour } from './padels/allowed.booking.hour.seeder';
import { SeedPromoCode } from './padels/promo.code.seeder';
import { SeedDuration } from './padels/booking.duration.seed';
import { SeedSchedule } from './padels/padel.schedule.seeder';
import { Address } from '../../../modules/users/domain/entities/address.entity';
import { User } from '../../../modules/users/domain/entities/user.entity';
import { Location } from '../../../modules/users/domain/entities/location.entity';
import { Notification } from '../../../modules/notifications/domain/entities/notification.entity';
import { Token } from '../../../modules/auth/domain/entities/token.entity';
import { PadelOrder } from '../../../modules/booking/domain/entities/padel.order.entity';
import { Payment } from '../../../modules/booking/domain/entities/payment.entity';
import { AllowedBookingHour } from '../../../modules/padels/domain/entities/allowed.booking.hour.entity';
import { PromoCode } from '../../../modules/padels/domain/entities/promo.code.entity';
import { PadelSchedule } from '../../../modules/padels/domain/entities/padel.schedule.entity';
import { PadelFeature } from '../../../modules/padels/domain/entities/padel.feature';
import { PostImage } from '../../../modules/posts/domain/entities/post.image.entity';
import { Bookmark } from '../../../modules/padels/domain/entities/bookmark.entity';
import { Padel } from '../../../modules/padels/domain/entities/padel.entity';

import { Duration } from '../../../modules/padels/domain/entities/duration.entity';
import { PadelGroup } from '../../../modules/padels/domain/entities/padel.group.entity';
import { PostGroup } from '../../../modules/posts/domain/entities/post.group.entity';
import { Feature } from '../../../modules/padels/domain/entities/feature.entity';
import { Post } from '../../../modules/posts/domain/entities/post.entity';
import { Setting } from '../../../modules/users/domain/entities/setting.entity';
import { SeedPadelPadelGroup } from './padels/padel.padel.group.seeder';
import { SeedSetting } from './user/setting.seeder';
import { PadelPadelGroup } from '../../../modules/padels/domain/entities/padel.padel.group';
import { SeedSysVar } from './user/sys.var.seeder';
import { SeedAd } from './ad/ads.seeder';
import { SystemVariable } from '../../../modules/users/domain/entities/system.variable.entity';
import { Ad } from '../../../modules/ads/domain/entities/ad.entity';

export class Migrate {
  async run(): Promise<boolean> {
    await SystemVariable.sync({ force: true });

    await Address.sync({ force: true });
    await Location.sync({ force: true });
    await User.sync({ force: true });
    await Token.sync({ force: true });
    await Ad.sync({ force: true });

    await Notification.sync({ force: true });
    await Feature.sync({ force: true });
    await PostGroup.sync({ force: true });
    await PadelGroup.sync({ force: true });
    await Setting.sync({ force: true });
    await Duration.sync({ force: true });

    await Post.sync({ force: true });
    await Padel.sync({ force: true });
    await PadelPadelGroup.sync({ force: true });
    await Bookmark.sync({ force: true });
    await PostImage.sync({ force: true });
    await PadelFeature.sync({ force: true });

    await PadelSchedule.sync({ force: true });
    await PromoCode.sync({ force: true });
    await AllowedBookingHour.sync({ force: true });

    await Payment.sync({ force: true });
    await PadelOrder.sync({ force: true });

    return true;
  }

  async seed(): Promise<boolean> {
    await new SeedAddress().run();
    await new SeedLocation().run();
    if (process.env.ENV == 'DEV') await new SeedUser().run();
    if (process.env.ENV == 'DEV') await new SeedSetting().run();
    if (process.env.ENV == 'DEV') await new SeedToken().run();
    await new SeedPadelGroup().run();
    await new SeedFeature().run();
    await new SeedPostGroup().run();
    await new SeedDuration().run();
    if (process.env.ENV == 'DEV') await new SeedSysVar().run();

    if (process.env.ENV == 'DEV') await new SeedPadel().run();
    if (process.env.ENV == 'DEV') await new SeedAd().run();

    if (process.env.ENV == 'DEV') await new SeedPadelPadelGroup().run();
    if (process.env.ENV == 'DEV') await new SeedAllowedBookingHour().run();
    if (process.env.ENV == 'DEV') await new SeedPadelFeature().run();
    if (process.env.ENV == 'DEV') await new SeedPost().run();
    if (process.env.ENV == 'DEV') await new SeedPostImage().run();
    if (process.env.ENV == 'DEV') await new SeedPayment().run();
    if (process.env.ENV == 'DEV') await new SeedSchedule().run();
    if (process.env.ENV == 'DEV') await new SeedPadelOrder().run();
    if (process.env.ENV == 'DEV') await new SeedBookmark().run();
    if (process.env.ENV == 'DEV') await new SeedNotification().run();
    if (process.env.ENV == 'DEV') await new SeedPromoCode().run();

    return true;
  }

  async rollback(): Promise<boolean> {
    await new SeedAd().clean();
    await new SeedSysVar().clean();
    await new SeedNotification().clean();
    await new SeedPostImage().clean();
    await new SeedPost().clean();
    await new SeedPadelFeature().clean();
    await new SeedAllowedBookingHour().clean();
    await new SeedPadelOrder().clean();
    await new SeedPayment().clean();
    await new SeedPromoCode().clean();
    await new SeedBookmark().clean();
    await new SeedSchedule().clean();
    await new SeedPadelPadelGroup().clean();
    await new SeedPadel().clean();
    await new SeedDuration().clean();
    await new SeedPostGroup().clean();
    await new SeedFeature().clean();
    await new SeedPadelGroup().clean();
    await new SeedToken().clean();
    await new SeedSetting().clean();
    await new SeedUser().clean();
    await new SeedLocation().clean();
    await new SeedAddress().clean();
    return true;
  }
}
