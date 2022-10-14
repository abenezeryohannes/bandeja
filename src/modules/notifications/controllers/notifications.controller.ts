import { Controller, Get, Query, Request } from '@nestjs/common';
import { WrapperDto } from 'src/core/dto/wrapper.dto';
import { Roles } from 'src/modules/auth/domain/guards/roles.decorator';
import { ROLE } from 'src/modules/users/infrastructure/dto/user.dto';
import { NotificationsService } from '../domain/services/notifications.service';

@Controller('notifications')
export class NotificationsController {
  constructor(private readonly notificationService: NotificationsService) {}

  @Roles(ROLE.ADMIN, ROLE.OWNER, ROLE.USER)
  @Get()
  findAll(@Request() request, @Query() query) {
    try {
      const result = this.notificationService.findAll(request.user, query);
      return WrapperDto.paginate(result, query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }
}
