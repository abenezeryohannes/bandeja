import { APP_GUARD } from '@nestjs/core'; 
import { RolesGuard } from './domain/guards/roles.guard';
import { Token } from './domain/entities/token.entity';
import { DoesUserExist } from './domain/guards/does.user.exist.guard';
import { DOES_USER_EXIST_GUARD, TOKEN_REPOSITORY } from '../../core/constants';

export const GuardsProvider = [
  {
    provide: APP_GUARD,
    useClass: RolesGuard,
  },
  {
    provide: DOES_USER_EXIST_GUARD,
    useClass: DoesUserExist,
  },
  {
    provide: TOKEN_REPOSITORY,
    useValue: Token,
  },
];
