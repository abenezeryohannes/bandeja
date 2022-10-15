import {
  Controller,
  Request,
  Get,
  Query,
  Post,
  UseInterceptors,
  Param,
  Body,
} from '@nestjs/common';
import { WrapperDto } from 'src/core/dto/wrapper.dto';
import { Roles } from 'src/modules/auth/domain/guards/roles.decorator';
import { ROLE } from 'src/modules/users/infrastructure/dto/user.dto';
import { PostsService } from '../domain/services/posts.service';
import { diskStorage } from 'multer';

import { FastifyFilesInterceptor } from 'src/fastify.multiple.file.interceptor';
import { editFileName, imageFileFilter } from 'src/core/dto/file.upload.util';
import { join } from 'path';
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
  // @UseInterceptors(TransactionInterceptor)
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
  @Post('delete')
  async delete(@Body() body, @Request() request) {
    try {
      const result = await this.postsService.destroy(body.postId, request);
      return WrapperDto.successfull(result >= 1);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }
}
