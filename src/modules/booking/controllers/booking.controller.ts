import {
  Controller,
  Request,
  Get,
  Query,
  Post,
  Body,
  UseInterceptors,
} from '@nestjs/common';
import { TransactionInterceptor } from 'src/core/database/decorators/transaction.interceptor';
import { WrapperDto } from 'src/core/dto/wrapper.dto';
import { Roles } from 'src/modules/auth/domain/guards/roles.decorator';
import { ROLE } from 'src/modules/users/infrastructure/dto/user.dto';
import { BookingService } from '../domain/services/booking.service';
import { OrderDto } from '../infrastructure/dto/order.dto';

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
  async book(@Request() request, @Body() orderDto: OrderDto) {
    try {
      const result = await this.bookingService.book(request, orderDto);
      return WrapperDto.successfull(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }
}
