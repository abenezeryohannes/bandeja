import {
  Controller,
  Get,
  Post,
  Request,
  UseInterceptors,
} from '@nestjs/common';
import { diskStorage } from 'multer';
import { join } from 'path';
import {
  editFileName,
  imageFileFilter,
} from '../../../core/dto/file.upload.util';
import { WrapperDto } from '../../../core/dto/wrapper.dto';
import { FastifyFileInterceptor } from '../../../fastify.file.interceptor';
import { Roles } from '../../auth/domain/guards/roles.decorator';
import { UsersService } from '../domain/services/users.service';
import { ROLE } from '../infrastructure/dto/user.dto';

@Controller('users')
export class UsersController {
  constructor(private userService: UsersService) {}

  @Roles(ROLE.ADMIN, ROLE.OWNER, ROLE.USER)
  @Post('edit')
  @UseInterceptors(
    FastifyFileInterceptor('avatar', {
      storage: diskStorage({
        destination: join(process.cwd(), 'assets', 'public'),
        filename: editFileName,
      }),
      fileFilter: imageFileFilter,
    }),
  )
  async edit(@Request() request) {
    try {
      const result = await this.userService.edit(request, request.body);
      return WrapperDto.successfullCreated(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN, ROLE.OWNER, ROLE.USER)
  @Get()
  async get(@Request() request) {
    try {
      const result = await this.userService.findOneById(request.user.id);
      return WrapperDto.successfullCreated(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }
}
