import {
  Controller,
  Request,
  Post,
  UseInterceptors,
  Query,
  Get,
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
import { FastifyFilesInterceptor } from '../../../fastify.multiple.file.interceptor';
import { Roles } from '../../auth/domain/guards/roles.decorator';
import { ROLE } from '../../users/infrastructure/dto/user.dto';
import { AdsService } from '../domain/services/ads.service';
import { AdEditDto } from '../infrastructure/ad.edit.dto';

@Controller('ads')
export class AdsController {
  constructor(private readonly adService: AdsService) {}

  @Roles(ROLE.ADMIN, ROLE.OWNER, ROLE.USER)
  @Get()
  async findAll(@Query() query) {
    try {
      const result = await this.adService.findAll(query);
      return WrapperDto.paginate(result, query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN, ROLE.OWNER, ROLE.USER)
  @Post('add')
  @UseInterceptors(TransactionInterceptor)
  @UseInterceptors(
    FastifyFilesInterceptor('file', 1, {
      storage: diskStorage({
        destination: join(process.cwd(), 'assets', 'public'),
        filename: editFileName,
      }),
      fileFilter: imageFileFilter,
    }),
  )
  async add(
    // @UploadedFiles() files: Array<Express.Multer.File>,
    @Request() req,
  ) {
    try {
      const result = await this.adService.create(req, req.body);
      return WrapperDto.successfull(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN)
  @Post('edit')
  @UseInterceptors(TransactionInterceptor)
  @UseInterceptors(
    FastifyFilesInterceptor('file', 1, {
      storage: diskStorage({
        destination: join(process.cwd(), 'assets', 'public'),
        filename: editFileName,
      }),
      fileFilter: imageFileFilter,
    }),
  )
  async edit(@Request() request) {
    try {
      const postEditDto = new AdEditDto(request.body);
      await validateOrReject(postEditDto);
      const result = await this.adService.edit(request, postEditDto);
      return WrapperDto.successfull(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN, ROLE.USER)
  @UseInterceptors(TransactionInterceptor)
  @Post('delete')
  async delete(@Request() request) {
    try {
      await this.adService.delete(request.body.id);
      return WrapperDto.successfull(true);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }
}
