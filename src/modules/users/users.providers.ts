import { User } from './domain/entities/user.entity';
import { Address } from './domain/entities/address.entity';
import { Location } from './domain/entities/location.entity';
import {
  ADDRESS_REPOSITORY,
  APP_VISIT_REPOSITORY,
  LOCATION_REPOSITORY,
  SETTING_REPOSITORY,
  USER_REPOSITORY,
} from '../../core/constants';
import { Setting } from './domain/entities/setting.entity';
import { AppVisit } from './domain/entities/app.visit.entity';

export const usersProviders = [
  {
    provide: USER_REPOSITORY,
    useValue: User,
  },
  {
    provide: ADDRESS_REPOSITORY,
    useValue: Address,
  },
  {
    provide: LOCATION_REPOSITORY,
    useValue: Location,
  },
  {
    provide: SETTING_REPOSITORY,
    useValue: Setting,
  },
  {
    provide: APP_VISIT_REPOSITORY,
    useValue: AppVisit,
  },
];
