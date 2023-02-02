import {
  Controller,
  Get,
  Param,
  Post,
  Query,
  Request,
  UseInterceptors,
} from '@nestjs/common';
import { validateOrReject } from 'class-validator';
import { query } from 'express';
import { diskStorage } from 'multer';
import { join } from 'path';
import { TransactionInterceptor } from '../../../core/database/decorators/transaction.interceptor';
import {
  editFileName,
  imageFileFilter,
} from '../../../core/dto/file.upload.util';
import { WrapperDto } from '../../../core/dto/wrapper.dto';
import { FastifyFileFieldsInterceptor } from '../../../fastify.file.fields.interceptor';
import { Roles } from '../../auth/domain/guards/roles.decorator';
import { ROLE } from '../../users/infrastructure/dto/user.dto';
import { PadelsService } from '../domain/services/padels.service';
import { FilterPadelDto } from '../infrastructure/dto/filter.padel.dto';
import { PadelAddDto } from '../infrastructure/dto/padel.add.dto';
import { PadelEditDto } from '../infrastructure/dto/padel.edit.dto';
import { PadelScheduleDto } from '../infrastructure/dto/padel.schedule.dto';
import { PromoCodeDto } from '../infrastructure/dto/promo.code.dto';

@Controller('padels')
export class PadelsController {
  constructor(private readonly padelsService: PadelsService) {}

  @Roles(ROLE.ADMIN, ROLE.OWNER, ROLE.USER)
  @Get()
  async findAll(@Query() query: any) {
    try {
      const filterPadelDto = new FilterPadelDto(query);
      await validateOrReject(filterPadelDto);
      const result = await this.padelsService.findAllPadels(filterPadelDto);
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
      return WrapperDto.paginate(result, result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }
  @Roles(ROLE.ADMIN, ROLE.OWNER, ROLE.USER)
  @Get('durations')
  async durations(@Request() request, @Query() query) {
    try {
      const result = await this.padelsService.findAllDurations(query);
      return WrapperDto.paginate(result, result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN, ROLE.OWNER, ROLE.USER)
  @Get(':id')
  async findOne(@Request() request, @Query() query, @Param('id') id: number) {
    try {
      const result = await this.padelsService.findOne(
        request.user,
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

  @Roles(ROLE.OWNER)
  @Get('schedules')
  async findAllOwnerSchedules(@Request() request: any) {
    try {
      const filterPadelDto = new FilterPadelDto(request.query);
      await validateOrReject(filterPadelDto);
      const result = await this.padelsService.findAllOwnerPadelsWithSchedules(
        request.user,
        filterPadelDto,
      );
      return WrapperDto.paginate(result, query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.OWNER)
  @Post('editSchedule')
  async editSchedule(@Request() request: any) {
    try {
      const scheduleDto = new PadelScheduleDto(request.body);
      await validateOrReject(scheduleDto);

      const result = await this.padelsService.editSchedule(
        request,
        scheduleDto,
      );

      return WrapperDto.paginate(result, query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.OWNER, ROLE.ADMIN, ROLE.USER)
  @Post('findOneWithPeriod')
  async findOneWithPeriod(@Request() request: any) {
    try {
      const result = await this.padelsService.findOneWithPeriod(request);
      return WrapperDto.paginate(result, query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.OWNER)
  @Post('add')
  @UseInterceptors(TransactionInterceptor)
  @UseInterceptors(
    FastifyFileFieldsInterceptor(
      [
        { name: 'avatar', maxCount: 1 },
        { name: 'banner', maxCount: 1 },
      ],
      {
        storage: diskStorage({
          destination: join(process.cwd(), 'assets', 'public'),
          filename: editFileName,
        }),
        fileFilter: imageFileFilter,
      },
    ),
  )
  async addPadel(@Request() request: any) {
    try {
      const padelDto = new PadelAddDto(request.body);
      await validateOrReject(padelDto);

      const result = await this.padelsService.addPadel(request, padelDto);
      return WrapperDto.successfullCreated(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.OWNER, ROLE.ADMIN)
  @Post('edit')
  @UseInterceptors(TransactionInterceptor)
  @UseInterceptors(
    FastifyFileFieldsInterceptor(
      [
        { name: 'avatar', maxCount: 1 },
        { name: 'banner', maxCount: 1 },
      ],
      {
        storage: diskStorage({
          destination: join(process.cwd(), 'assets', 'public'),
          filename: editFileName,
        }),
        fileFilter: imageFileFilter,
      },
    ),
  )
  async editPadel(@Request() request: any) {
    try {
      const padelDto = new PadelEditDto(request.body);
      await validateOrReject(padelDto);

      const result = await this.padelsService.editPadel(request, padelDto);
      return WrapperDto.successfullCreated(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.OWNER)
  @Get('all')
  async findAllOwner(@Request() request: any) {
    try {
      const result = await this.padelsService.findAllOwnersPadels(
        request.user,
        request.query,
      );
      return WrapperDto.paginate(result, query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.OWNER)
  @Get('findAllPromoCodes')
  async findAllPromoCodes(@Request() request: any) {
    try {
      const result = await this.padelsService.findAllPromoCodes(request.user);
      return WrapperDto.paginate(result, query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.OWNER, ROLE.ADMIN)
  @Get('findAllFeatures')
  async findAllFeatures(@Request() request: any) {
    try {
      const result = await this.padelsService.findAllFeatures(request.query);
      return WrapperDto.paginate(result, query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.OWNER)
  @Get('findAllDurations')
  async findAllDurations(@Request() request: any) {
    try {
      const result = await this.padelsService.findAllDurations(request.query);
      return WrapperDto.paginate(result, query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.OWNER, ROLE.ADMIN, ROLE.USER)
  @Get('getPromoCode')
  async getPromoCode(@Request() request) {
    try {
      const result = await this.padelsService.getPromoCode(request);
      return WrapperDto.successfullCreated(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.OWNER)
  @Post('addPromoCode')
  async addPromoCode(@Request() request) {
    try {
      const promoCodeDto = new PromoCodeDto(request.body);
      await validateOrReject(promoCodeDto);
      const result = await this.padelsService.addPromoCode(
        request,
        promoCodeDto,
      );
      return WrapperDto.successfullCreated(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.OWNER)
  @Post('editPromoCode')
  async editPromoCode(@Request() request) {
    try {
      const result = await this.padelsService.editPromoCode(
        request,
        request.body,
      );
      return WrapperDto.successfullCreated(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN)
  @Get('findAllPadels')
  async findAllPadels(@Query() query: any) {
    try {
      const result = await this.padelsService.findAllAdminPadels(query);
      return WrapperDto.paginate(result, query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN)
  @Get('findAllPadelsForApproval')
  async findAllPadelsForApproval(@Query() query: any) {
    try {
      const result = await this.padelsService.findAllPadelsForApproval(query);
      return WrapperDto.paginate(result, query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN)
  @Get('countAll')
  async countAllPadels() {
    try {
      const result = await this.padelsService.countAllPadels();
      return WrapperDto.successfull(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }
}
