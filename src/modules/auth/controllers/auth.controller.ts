import {
  Controller,
  Body,
  Post,
  Request,
  UseGuards,
  Get,
} from '@nestjs/common';
import { WrapperDto } from '../../../core/dto/wrapper.dto';
import { ROLE } from '../../users/infrastructure/dto/user.dto';
import { DoesUserExist } from '../domain/guards/does.user.exist.guard';
import { Roles } from '../domain/guards/roles.decorator';
import { AuthService } from '../domain/services/auth.service';

@Controller('auth')
export class AuthController {
  constructor(private authService: AuthService) {}

  @Post('login')
  async login(@Request() request, @Body() body: any) {
    try {
      const response = await this.authService.login(request, body);
      return WrapperDto.successfullCreated(response);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @UseGuards(DoesUserExist)
  @Post('signup')
  async signUp(@Request() request: any) {
    try {
      const response = await this.authService.signUp(request, request.body);
      return WrapperDto.successfullCreated(response);
    } catch (error) {
      await request.transaction.rollback();
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN, ROLE.OWNER, ROLE.USER)
  @Post('logout')
  async logOut(@Request() request) {
    try {
      return await this.authService.logout(request.Token);
    } catch (error) {
      await request.transaction.rollback();
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN, ROLE.OWNER, ROLE.USER)
  @Post('updateFCM')
  async updateFCM(@Request() request) {
    try {
      const result = await this.authService.updateFCM(request);
      return WrapperDto.successfullCreated(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }
}
