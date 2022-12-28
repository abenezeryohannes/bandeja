import {
  Body,
  Controller,
  Get,
  Param,
  Post,
  Query,
  Request,
  UseInterceptors,
} from '@nestjs/common';
import { validateOrReject } from 'class-validator';
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
import { PadelGroupService } from '../domain/services/padel_group.service';
import { PadelGroupDto } from '../infrastructure/dto/padel.group.dto';
import { PadelGroupEditDto } from '../infrastructure/dto/padel.group.edit';

@Controller('padel-group')
export class PadelGroupController {
  constructor(private readonly padelGroupsService: PadelGroupService) {}

  @Roles(ROLE.ADMIN, ROLE.OWNER, ROLE.USER)
  @Get()
  async findAll(@Query() query) {
    try {
      const result = await this.padelGroupsService.findAll(query);
      return WrapperDto.paginate(result, query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN)
  @Get('findAll')
  async findAllForAdmin(@Query() query) {
    try {
      const result = await this.padelGroupsService.findAllForAdmin(query);
      return WrapperDto.paginate(result, query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }
  @Roles(ROLE.ADMIN)
  @Get(':id')
  async findOne(@Param() query) {
    try {
      const result = await this.padelGroupsService.findAllForAdmin(query);
      return WrapperDto.paginate(result, query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN)
  @Post('edit')
  @UseInterceptors(TransactionInterceptor)
  @UseInterceptors(
    FastifyFileFieldsInterceptor([{ name: 'icon', maxCount: 1 }], {
      storage: diskStorage({
        destination: join(process.cwd(), 'assets', 'img'),
        filename: editFileName,
      }),
      fileFilter: imageFileFilter,
    }),
  )
  async edit(@Request() request) {
    try {
      const padelGroupBody = new PadelGroupEditDto(request.body);
      await validateOrReject(padelGroupBody);

      const result = await this.padelGroupsService.edit(
        request,
        padelGroupBody,
      );
      return WrapperDto.successfullCreated(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN)
  @Post('store')
  @UseInterceptors(TransactionInterceptor)
  @UseInterceptors(
    FastifyFileFieldsInterceptor([{ name: 'icon', maxCount: 1 }], {
      storage: diskStorage({
        destination: join(process.cwd(), 'assets', 'img'),
        filename: editFileName,
      }),
      fileFilter: imageFileFilter,
    }),
  )
  async store(@Request() request) {
    try {
      const padelGroupBody = new PadelGroupDto(request.body);
      await validateOrReject(padelGroupBody);

      const result = await this.padelGroupsService.store(
        request,
        padelGroupBody,
      );
      return WrapperDto.successfullCreated(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN)
  @Post('delete')
  async delete(@Request() request, @Body() body) {
    try {
      const result = await this.padelGroupsService.delete(body.id);
      return WrapperDto.successfull(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN)
  @Post('deleteAll')
  async deleteAll(@Request() request, @Body() body) {
    try {
      const result = await this.padelGroupsService.deleteAll(
        JSON.parse(body.ids),
      );
      return WrapperDto.successfull(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }
}
