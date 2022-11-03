import {
  Controller,
  Get,
  Post,
  Request,
  UseInterceptors,
} from '@nestjs/common';
import { validateOrReject } from 'class-validator';
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
import { UserEditDto } from '../infrastructure/dto/user.edit.dto';

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
      const userEditDto = new UserEditDto(request.body);
      await validateOrReject(userEditDto);
      const result = await this.userService.edit(request, userEditDto);
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

  @Roles(ROLE.ADMIN)
  @Get('getAllOwnerAndAdmins')
  async getAllOwnerAndAdmins(@Request() request) {
    try {
      const result = await this.userService.findAllOwnerAndAdmins(request);
      return WrapperDto.paginate(result, request.query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN, ROLE.OWNER, ROLE.USER)
  @Get('visitStart')
  async visitStart(@Request() request) {
    try {
      const result = await this.userService.visitStart(request);
      return WrapperDto.successfullCreated(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN, ROLE.OWNER, ROLE.USER)
  @Get('visitEnd')
  async visitEnd(@Request() request) {
    try {
      const result = await this.userService.visitEnd(request);
      return WrapperDto.successfullCreated(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }
}
