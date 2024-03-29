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
import { LocationDto } from '../infrastructure/dto/location.dto';
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
      limits: {
        fieldSize: 10485760,
      },
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

  @Roles(ROLE.ADMIN)
  @Get('findAllUsers')
  async findAllUsers(@Request() request) {
    try {
      const result = await this.userService.findAllUsers(request);
      return WrapperDto.paginate(result, request.query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN)
  @Get('findAllOwners')
  async findAllOwners(@Request() request) {
    try {
      const result = await this.userService.findAllOwners(request);
      return WrapperDto.paginate(result, request.query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN)
  @Get('findAllAdmins')
  async findAllAdmins(@Request() request) {
    try {
      const result = await this.userService.findAllAdmins(request);
      return WrapperDto.paginate(result, request.query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN)
  @Get('findAllCustomers')
  async findAllCustomers(@Request() request) {
    try {
      const result = await this.userService.findAllCustomers(request);
      return WrapperDto.paginate(result, request.query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN, ROLE.OWNER, ROLE.USER)
  @Post('visitStart')
  async visitStart(@Request() request) {
    try {
      const result = await this.userService.visitStart(request);
      return WrapperDto.successfullCreated(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN, ROLE.OWNER, ROLE.USER)
  @Post('visitEnd')
  async visitEnd(@Request() request) {
    try {
      const result = await this.userService.visitEnd(request);
      return WrapperDto.successfullCreated(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  // @Roles(ROLE.ADMIN, ROLE.OWNER, ROLE.USER)
  @Post('getSysVar')
  async getSysVar(@Request() request) {
    try {
      const result = await this.userService.getSysVar(request);
      return WrapperDto.successfull(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN, ROLE.OWNER, ROLE.USER)
  @Post('setSysVar')
  async setSysVar(@Request() request) {
    try {
      const result = await this.userService.setSysVar(request);
      return WrapperDto.successfullCreated(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN, ROLE.OWNER, ROLE.USER)
  @Post('editLocation')
  async editLocation(@Request() request) {
    try {
      const locationDto = new LocationDto(request.body);
      await validateOrReject(locationDto);

      const result = await this.userService.editUserLocation(
        request,
        locationDto,
      );

      return WrapperDto.successfullCreated(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }
}
