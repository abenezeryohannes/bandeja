import { APP_GUARD } from '@nestjs/core';
import { DOES_USER_EXIST_GUARD, TOKEN_REPOSITORY } from 'src/core/constants';
import { RolesGuard } from './domain/guards/roles.guard';
import { Token } from './domain/entities/token.entity';
import { DoesUserExist } from './domain/guards/does.user.exist.guard';

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
