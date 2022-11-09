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
  async findAll(@Request() request) {
    try {
      const result = await this.notificationService.findAll(
        request.user,
        request.query,
      );
      return WrapperDto.paginate(result, request.query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }
  @Roles(ROLE.ADMIN, ROLE.OWNER, ROLE.USER)
  @Get('findAllUnSeen')
  async findAllUnSeen(@Request() request) {
    try {
      const result = await this.notificationService.findAllUnseen(
        request.user,
        request.query,
      );
      return WrapperDto.paginate(result, request.query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN, ROLE.OWNER, ROLE.USER)
  @Post('seen')
  async seen(@Request() request, @Body() seen: seenDto) {
    try {
      const result = await this.notificationService.seen(request, seen);
      return WrapperDto.successfull(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN, ROLE.OWNER, ROLE.USER)
  @Get('unSeenCount')
  async unseenCount(@Request() request) {
    try {
      const result = await this.notificationService.unseenCount(request);
      return WrapperDto.successfull(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN, ROLE.OWNER, ROLE.USER)
  @Post('clear')
  async clear(@Request() request) {
    try {
      const result = await this.notificationService.clear(request);
      return WrapperDto.successfull(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }
  @Roles(ROLE.ADMIN)
  @Post('send')
  async send(@Request() request) {
    try {
      const result = await this.notificationService.SendMessage(
        request,
        request.body,
        true,
      );
      return WrapperDto.successfull(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }
}
