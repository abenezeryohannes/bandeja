import { Notification } from 'src/modules/notifications/domain/entities/notification.entity';
import { Payment } from 'src/modules/booking/domain/entities/payment.entity';
import { PadelFeature } from 'src/modules/padels/domain/entities/padel.feature';
import { Padel } from 'src/modules/padels/domain/entities/padel.entity';
import { Post } from 'src/modules/posts/domain/entities/post.entity';
import { Bookmark } from 'src/modules/padels/domain/entities/bookmark.entity';
import { Feature } from 'src/modules/padels/domain/entities/feature.entity';
import { Token } from 'src/modules/auth/domain/entities/token.entity';
import { Location } from 'src/modules/users/domain/entities/location.entity';
import { User } from 'src/modules/users/domain/entities/user.entity';
import { PadelGroup } from 'src/modules/padels/domain/entities/padel.group.entity';
import { PostGroup } from 'src/modules/posts/domain/entities/post.group.entity';
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
import { PostImage } from 'src/modules/posts/domain/entities/post.image.entity';
import { SeedPadelFeature } from './padels/padel.feature.seeder';
import { AllowedBookingHour } from 'src/modules/padels/domain/entities/allowed.booking.hour.entity';
import { PromoCode } from 'src/modules/padels/domain/entities/promo.code.entity';
import { PadelSchedule } from 'src/modules/padels/domain/entities/padel.schedule.entity';
import { SeedAllowedBookingHour } from './padels/allowed.booking.hour.seeder';
import { SeedPromoCode } from './padels/promo.code.seeder';
import { SeedDuration } from './padels/booking.duration.seed';
import { SeedSchedule } from './padels/padel.schedule.seeder';
import { PadelOrder } from 'src/modules/booking/domain/entities/padel.order.entity';
import { Duration } from 'src/modules/padels/domain/entities/duration.entity';
import { Address } from 'src/modules/users/domain/entities/address.entity';

export class Migrate {
  async run(): Promise<boolean> {
    await Address.sync({ force: true });
    await Location.sync({ force: true });
    await User.sync({ force: true });
    await Token.sync({ force: true });

    await Notification.sync({ force: true });
    await Feature.sync({ force: true });
    await PostGroup.sync({ force: true });
    await PadelGroup.sync({ force: true });
    await Duration.sync({ force: true });

    await Post.sync({ force: true });
    await Padel.sync({ force: true });
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
    await new SeedUser().run();
    await new SeedToken().run();
    await new SeedPadelGroup().run();
    await new SeedFeature().run();
    await new SeedPostGroup().run();
    await new SeedDuration().run();
    await new SeedPadel().run();
    await new SeedAllowedBookingHour().run();
    await new SeedPadelFeature().run();
    await new SeedPost().run();
    await new SeedPostImage().run();
    await new SeedPayment().run();
    await new SeedPromoCode().run();
    await new SeedSchedule().run();
    await new SeedPadelOrder().run();
    await new SeedBookmark().run();
    await new SeedNotification().run();

    return true;
  }

  async rollback(): Promise<boolean> {
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
    await new SeedPadel().clean();
    await new SeedDuration().clean();
    await new SeedPostGroup().clean();
    await new SeedFeature().clean();
    await new SeedPadelGroup().clean();
    await new SeedToken().clean();
    await new SeedUser().clean();
    await new SeedLocation().clean();
    await new SeedAddress().clean();
    return true;
  }
}
