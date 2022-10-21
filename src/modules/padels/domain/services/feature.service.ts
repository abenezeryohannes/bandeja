import { Inject, Injectable } from '@nestjs/common'; 
import { FEATURE_REPOSITORY } from '../../../../core/constants';
import { Feature } from '../entities/feature.entity';

@Injectable()
export class FeatureService {
  constructor(
    @Inject(FEATURE_REPOSITORY)
    private readonly FeaturesRepository: typeof Feature,
  ) {}
}
