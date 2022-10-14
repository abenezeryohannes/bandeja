import {
  BOOKMARK_REPOSITORY,
  FEATURE_REPOSITORY,
  PADEL_GROUP_REPOSITORY,
  PADEL_FEATURE_REPOSITORY,
  PADEL_REPOSITORY,
  ALLOWED_BOOKING_HOUR_REPOSITORY,
  PROMO_CODE_REPOSITORY,
  PADEL_PRICESS_REPOSITORY,
  PADEL_SCHEDULE_REPOSITORY,
  BOOKING_DURATION_REPOSITORY,
} from 'src/core/constants';
import { Bookmark } from './domain/entities/bookmark.entity';
import { Feature } from './domain/entities/feature.entity';
import { Padel } from './domain/entities/padel.entity';
import { PadelGroup } from './domain/entities/padel.group.entity';
import { PadelFeature } from './domain/entities/padel.feature';
import { PromoCode } from './domain/entities/promo.code.entity';
import { PadelPrices } from './domain/entities/podel.pricess.entity';
import { PadelSchedule } from './domain/entities/padel.schedule.entity';
import { Duration } from './domain/entities/duration.entity';
import { AllowedBookingHour } from './domain/entities/allowed.booking.hour.entity';

export const PadelsProvider = [
  {
    provide: FEATURE_REPOSITORY,
    useValue: Feature,
  },
  {
    provide: PADEL_GROUP_REPOSITORY,
    useValue: PadelGroup,
  },
  {
    provide: BOOKMARK_REPOSITORY,
    useValue: Bookmark,
  },
  {
    provide: PADEL_REPOSITORY,
    useValue: Padel,
  },
  {
    provide: PADEL_FEATURE_REPOSITORY,
    useValue: PadelFeature,
  },
  {
    provide: ALLOWED_BOOKING_HOUR_REPOSITORY,
    useValue: AllowedBookingHour,
  },
  {
    provide: BOOKING_DURATION_REPOSITORY,
    useValue: Duration,
  },
  {
    provide: PADEL_SCHEDULE_REPOSITORY,
    useValue: PadelSchedule,
  },
  {
    provide: PADEL_PRICESS_REPOSITORY,
    useValue: PadelPrices,
  },
  {
    provide: PROMO_CODE_REPOSITORY,
    useValue: PromoCode,
  },
];
