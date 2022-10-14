import { Controller, Body, Post, Request, UseGuards } from '@nestjs/common';
import { WrapperDto } from 'src/core/dto/wrapper.dto';
import { ROLE, UserDto } from 'src/modules/users/infrastructure/dto/user.dto';
import { DoesUserExist } from '../domain/guards/does.user.exist.guard';
import { Roles } from '../domain/guards/roles.decorator';
import { AuthService } from '../domain/services/auth.service';

@Controller('auth')
export class AuthController {
  constructor(private authService: AuthService) {}

  @Post('login')
  async login(@Body() body: any) {
    return await this.authService.login(body);
  }

  @UseGuards(DoesUserExist)
  @Post('signup')
  async signUp(@Request() request: any) {
    try {
      return await this.authService.signUp(request.body);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN, ROLE.OWNER, ROLE.USER)
  @Post('logout')
  async logOut(@Request() request) {
    try {
      return await this.authService.logout(request.Token);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }
}
