import { Controller, Get, Param, Query, Request } from '@nestjs/common';
import { query } from 'express';
import { WrapperDto } from 'src/core/dto/wrapper.dto';
import { Roles } from 'src/modules/auth/domain/guards/roles.decorator';
import { ROLE } from 'src/modules/users/infrastructure/dto/user.dto';
import { PadelsService } from '../domain/services/padels.service';
import { FilterPadelDto } from '../infrastructure/dto/filter.padel.dto';

@Controller('padels')
export class PadelsController {
  constructor(private readonly padelsService: PadelsService) {}

  @Roles(ROLE.ADMIN, ROLE.OWNER, ROLE.USER)
  @Get()
  async findAll(@Query() finterPadelDto: FilterPadelDto) {
    try {
      const result = await this.padelsService.findAllPadels(finterPadelDto);
      return WrapperDto.paginate(result, query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN, ROLE.OWNER, ROLE.USER)
  @Get('featured')
  async featured(@Request() request, @Query() query) {
    try {
      const result = await this.padelsService.featured(request.user, query);
      return WrapperDto.paginate(result, query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN, ROLE.OWNER, ROLE.USER)
  @Get(':id')
  async findOne(@Request() request, @Query() query, @Param('id') id: number) {
    try {
      const result = await this.padelsService.findOne(
        query.date == null || query.date == ''
          ? new Date().toISOString()
          : query.date,
        id,
      );
      return WrapperDto.successfull(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }
}
