import { ADS_REPOSITORY } from '../../core/constants';
import { Ad } from './domain/entities/ad.entity';

export const AdsProvider = [
  {
    provide: ADS_REPOSITORY,
    useValue: Ad,
  },
];
