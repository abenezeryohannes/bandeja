import { Body, Controller, Get, Post, Query, Request } from '@nestjs/common';
import { WrapperDto } from '../../../core/dto/wrapper.dto';
import { Roles } from '../../auth/domain/guards/roles.decorator';
import { ROLE } from '../../users/infrastructure/dto/user.dto';
import { NotificationsService } from '../domain/services/notifications.service';
import { seenDto } from '../infrastructure/dto/seen.dto';

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
  @Roles(ROLE.ADMIN, ROLE.OWNER, ROLE.USER)
  @Post('seen')
  seeb(@Request() request, @Body() seen: seenDto) {
    try {
      const result = this.notificationService.seen(request, seen);
      return WrapperDto.successfull(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }
  @Roles(ROLE.ADMIN, ROLE.OWNER, ROLE.USER)
  @Post('clear')
  clear(@Request() request) {
    try {
      const result = this.notificationService.clear(request);
      return WrapperDto.successfull(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }
}
