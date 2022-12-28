import {
  Controller,
  Query,
  Get,
  Request,
  Post,
  Body,
  UseInterceptors,
} from '@nestjs/common';
import {
  editFileName,
  imageFileFilter,
} from '../../../core/dto/file.upload.util';
import { validateOrReject } from 'class-validator';
import { WrapperDto } from '../../../core/dto/wrapper.dto';
import { Roles } from '../../auth/domain/guards/roles.decorator';
import { ROLE } from '../../users/infrastructure/dto/user.dto';
import { PostGroupService } from '../domain/services/post.group.service';
import { PostGroupEditDto } from '../infrastructure/dto/post.group.edit.dto';
import { PostGroupDto } from '../infrastructure/dto/post.group.dto';
import { TransactionInterceptor } from '../../../core/database/decorators/transaction.interceptor';
import { FastifyFileFieldsInterceptor } from '../../../fastify.file.fields.interceptor';
import { diskStorage } from 'multer';
import { join } from 'path';

@Controller('postGroups')
export class PostGroupController {
  constructor(private readonly adGroupService: PostGroupService) {}

  @Roles(ROLE.ADMIN, ROLE.OWNER, ROLE.USER)
  @Get()
  async index(@Query() query) {
    try {
      const result = await this.adGroupService.findAll(query);
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
      const postGroupEditDto = new PostGroupEditDto(request.body);
      await validateOrReject(postGroupEditDto);

      const result = await this.adGroupService.edit(request, postGroupEditDto);
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
      const postGroupDto = new PostGroupDto(request.body);
      await validateOrReject(postGroupDto);

      const result = await this.adGroupService.store(request, postGroupDto);
      return WrapperDto.successfullCreated(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN)
  @Post('delete')
  async delete(@Request() request, @Body() body) {
    try {
      const result = await this.adGroupService.delete(body.id);
      return WrapperDto.successfull(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN)
  @Post('deleteAll')
  async deleteAll(@Request() request, @Body() body) {
    try {
      const result = await this.adGroupService.deleteAll(JSON.parse(body.ids));
      return WrapperDto.successfull(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }
}
