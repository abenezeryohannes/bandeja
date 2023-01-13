import {
  Controller,
  Request,
  Get,
  Query,
  Post,
  UseInterceptors,
} from '@nestjs/common';
import { validateOrReject } from 'class-validator';
import { TransactionInterceptor } from '../../../core/database/decorators/transaction.interceptor';
import { WrapperDto } from '../../../core/dto/wrapper.dto';
import { Roles } from '../../auth/domain/guards/roles.decorator';
import { ROLE } from '../../users/infrastructure/dto/user.dto';
import { BookingService } from '../domain/services/booking.service';
import { OrderDto } from '../infrastructure/dto/order.dto';
import { OrderEditDto } from '../infrastructure/dto/order.edit.dto';

@Controller('bookings')
export class BookingController {
  constructor(private readonly bookingService: BookingService) {}

  @Roles(ROLE.USER)
  @Get()
  async findAll(@Request() request, @Query() query) {
    try {
      const result = await this.bookingService.findAll(request.user, query);
      return WrapperDto.paginate(result, query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.USER)
  @Post('order')
  @UseInterceptors(TransactionInterceptor)
  async book(@Request() request) {
    try {
      const orderDto = new OrderDto(request.body);
      await validateOrReject(orderDto);

      const result = await this.bookingService.book(request, orderDto);
      return WrapperDto.successfullCreated(result);
    } catch (error) {
      try {
        await request.transaction.rollback();
      } catch (e) {}
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.OWNER)
  @Get('findAllOwner')
  async findAllOwner(@Request() request, @Query() query) {
    try {
      const result = await this.bookingService.findAllOwnerBookings(
        request.user,
        query,
      );
      return WrapperDto.paginate(result, query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.OWNER)
  @Get('ownerWeeklyStats')
  async ownerWeeklystats(@Request() request) {
    try {
      const result = await this.bookingService.ownerWeeklyStat(request.user);
      return WrapperDto.successfull(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.OWNER)
  @Get('ownerMonthlyStats')
  async ownerMonthlyStats(@Request() request) {
    try {
      const result = await this.bookingService.ownerMonthlyStat(
        request.user,
        request.query,
      );
      return WrapperDto.successfull(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.OWNER)
  @Post('getpaymentFromSchedule')
  async getpaymentFromSchedule(@Request() request) {
    try {
      const result = await this.bookingService.getpaymentFromSchedule(request);
      return WrapperDto.successfull(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.OWNER)
  @Post('editUserOrder')
  @UseInterceptors(TransactionInterceptor)
  async editUserOrder(@Request() request) {
    try {
      const orderEditDto = new OrderEditDto(request.body);
      await validateOrReject(orderEditDto);

      const result = await this.bookingService.editUserOrder(
        request,
        orderEditDto,
      );
      return WrapperDto.successfull(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.OWNER, ROLE.USER, ROLE.ADMIN)
  @Post('getBookingFromQrCode')
  async getBookingFromQrCode(@Request() request) {
    try {
      const result = await this.bookingService.getBookingFromQrCode(request);
      return WrapperDto.successfull(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN)
  @Get('findAllBookings')
  async findAllBookings(@Request() request, @Query() query) {
    try {
      const result = await this.bookingService.findAllBookings(
        request.user,
        query,
      );
      return WrapperDto.paginate(result, query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN)
  @Get('adminWeeklyStats')
  async adminWeeklystats(@Request() request) {
    try {
      const result = await this.bookingService.adminWeeklyStat(request.user);
      return WrapperDto.successfull(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN)
  @Get('adminMonthlyStats')
  async adminMonthlyStats(@Request() request) {
    try {
      const result = await this.bookingService.adminMonthlyStat(
        request.user,
        request.query,
      );
      return WrapperDto.successfull(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }
}
