import { Inject, Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt/dist/jwt.service';
import { TOKEN_REPOSITORY } from 'src/core/constants';
import { WrapperDto } from 'src/core/dto/wrapper.dto';
import { UsersService } from 'src/modules/users/domain/services/users.service';
import { Token } from '../entities/token.entity';
import * as Moment from 'moment';
import { ROLE, UserDto } from 'src/modules/users/infrastructure/dto/user.dto';

@Injectable()
export class AuthService {
  constructor(
    private readonly userService: UsersService,
    private readonly jwtService: JwtService,
    @Inject(TOKEN_REPOSITORY) private readonly tokenRepository: typeof Token,
  ) {}

  public async login(requestBody: any) {
    if (requestBody.phoneNumber == null || requestBody.UID == null)
      return WrapperDto.error(
        422,
        'UID and Phone Number is required to login!',
      );

    const user = await this.userService.findOneByPhoneNumber(
      requestBody.phoneNumber,
    );
    if (user == null)
      return WrapperDto.error(
        404,
        'No user registered with this phone number, please try to sign up.',
      );
    if (user.getDataValue('UID') != requestBody.UID)
      return WrapperDto.error(
        422,
        'Incorrect UID, please confirm your phone number first!',
      );

    if (requestBody.role == null) {
      return WrapperDto.error(422, 'Role is not provided');
    }
    if (
      (user.getDataValue('role') != ROLE.ADMIN &&
        requestBody.role == ROLE.ADMIN) ||
      (user.getDataValue('role') != ROLE.OWNER &&
        user.getDataValue('role') != ROLE.ADMIN &&
        requestBody.role == ROLE.OWNER)
    ) {
      return WrapperDto.error(
        403,
        'Sorry you can\'t sign up as "' +
          requestBody.role +
          '",Please try to use ' +
          user.getDataValue('role') +
          "'s app.",
      );
    }

    //get the highest role if the user is loging in as such
    if (user.getDataValue('role') == ROLE.USER) {
      user.role = requestBody.role;
      await user.save();
    }

    const userWithToken = await this.generateToken(
      user['dataValues'],
      requestBody.role,
    );

    return WrapperDto.successfullCreated(userWithToken);
  }

  public async logout(token: Token) {
    if (token != null) {
      await this.tokenRepository.destroy({
        where: { id: token.getDataValue('id') },
      });
    }
    return WrapperDto.successfull('Logout Successfull');
  }

  public async signUp(user: UserDto) {
    // create the user
    const newUser = await this.userService.create({ ...user });

    // generate token
    const newUserWIthToken = await this.generateToken(
      newUser['dataValues'],
      newUser.getDataValue('role'),
    );

    return WrapperDto.successfullCreated(newUserWIthToken);
  }

  private async generateToken(user, role: string) {
    const code = await this.jwtService.signAsync(user);
    const token = await this.tokenRepository.create<Token>({
      userId: user.id,
      token: code,
      until: Moment().add(Moment.duration(12, 'months')).toDate(),
      role: role,
    });
    const result = await this.userService.findUserWithToken(
      token.getDataValue('userId'),
      token.getDataValue('token'),
    );

    return result;
  }
}
