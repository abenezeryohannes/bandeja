import {
  Controller,
  Request,
  Get,
  Query,
  Post,
  UseInterceptors,
  Body,
} from '@nestjs/common';
import { PostsService } from '../domain/services/posts.service';
import { diskStorage } from 'multer';

import { join } from 'path';
import { Roles } from '../../auth/domain/guards/roles.decorator';
import { ROLE } from '../../users/infrastructure/dto/user.dto';
import { WrapperDto } from '../../../core/dto/wrapper.dto';
import { TransactionInterceptor } from '../../../core/database/decorators/transaction.interceptor';
import { FastifyFilesInterceptor } from '../../../fastify.multiple.file.interceptor';
import {
  editFileName,
  imageFileFilter,
} from '../../../core/dto/file.upload.util';
import { PostEditDto } from '../infrastructure/dto/post.edit.dto';
import { validateOrReject } from 'class-validator';
@Controller('posts')
export class PostsController {
  constructor(private readonly postsService: PostsService) {}

  @Roles(ROLE.ADMIN, ROLE.OWNER, ROLE.USER)
  @Get('featured')
  async featured(@Request() request, @Query() query) {
    try {
      const result = await this.postsService.featured(request.user, query);
      return WrapperDto.paginate(result, query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN, ROLE.OWNER, ROLE.USER)
  @Get()
  async posts(@Query() query) {
    try {
      const result = await this.postsService.findAll(query);
      return WrapperDto.paginate(result, query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN, ROLE.OWNER, ROLE.USER)
  @Get('mine')
  async mine(@Request() request, @Query() query) {
    try {
      const result = await this.postsService.findAllMine(request.user, query);
      return WrapperDto.paginate(result, query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN, ROLE.OWNER, ROLE.USER)
  @Post('add')
  @UseInterceptors(TransactionInterceptor)
  @UseInterceptors(
    FastifyFilesInterceptor('files', 5, {
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
      const result = await this.postsService.create(req, req.body);
      return WrapperDto.successfull(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN, ROLE.USER)
  @UseInterceptors(TransactionInterceptor)
  @Post('delete')
  async delete(@Body() body, @Request() request) {
    try {
      const result = await this.postsService.destroy(body.postId, request);
      return WrapperDto.successfull(result >= 1);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN)
  @Post('edit')
  @UseInterceptors(TransactionInterceptor)
  @UseInterceptors(
    FastifyFilesInterceptor('files', 5, {
      storage: diskStorage({
        destination: join(process.cwd(), 'assets', 'public'),
        filename: editFileName,
      }),
      fileFilter: imageFileFilter,
    }),
  )
  async edit(@Request() request) {
    try {
      const postEditDto = new PostEditDto(request.body);
      await validateOrReject(postEditDto);

      const result = await this.postsService.edit(request, postEditDto);
      return WrapperDto.successfull(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN)
  @Post('deleteAdmin')
  async deleteAdmin(@Request() request, @Body() body) {
    try {
      const result = await this.postsService.delete(body.id);
      return WrapperDto.successfull(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN)
  @Post('deleteAll')
  async deleteAll(@Request() request, @Body() body) {
    try {
      const result = await this.postsService.deleteAll(JSON.parse(body.ids));
      return WrapperDto.successfull(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }
}
