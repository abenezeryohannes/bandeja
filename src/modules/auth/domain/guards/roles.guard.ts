import {
  Injectable,
  CanActivate,
  ExecutionContext,
  Inject,
  ForbiddenException,
} from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { TOKEN_REPOSITORY } from 'src/core/constants';
import { User } from 'src/modules/users/domain/entities/user.entity';
import { UsersService } from 'src/modules/users/domain/services/users.service';
import { Token } from '../entities/token.entity';
import { Location } from '../../../users/domain/entities/location.entity';

@Injectable()
export class RolesGuard implements CanActivate {
  constructor(
    private reflector: Reflector,
    private readonly userService: UsersService,
    @Inject(TOKEN_REPOSITORY) private readonly tokenRepository: typeof Token,
  ) {}

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const permittedRoles = this.reflector.get<string[]>(
      'roles',
      context.getHandler(),
    );
    if (!permittedRoles) {
      return true;
    }
    const request = context.switchToHttp().getRequest();
    if (request.headers.authorization == null) {
      throw new ForbiddenException(
        'Please login or signup to make this request!',
      );
    }
    const jwt = request.headers.authorization.replace('Bearer ', '');

    const token = await this.tokenRepository.findOne({
      where: { token: jwt },
      include: [{ model: User, include: [Location] }],
    });

    if (token == null) return false;
    else {
      request.token = token;
      request.user = token.getDataValue('User');
      request.user.Token = token;
    }

    return matchRoles(token.role, permittedRoles);
  }
}

function matchRoles(
  role: string,
  permitedRoles: string[],
): boolean | Promise<boolean> {
  if (role == null) return false;
  if (permitedRoles.length == 0 || permitedRoles == null) return true;

  for (let j = 0; j < permitedRoles.length; j++) {
    if (role == permitedRoles[j]) {
      return true;
    }
  }

  return false;
}
