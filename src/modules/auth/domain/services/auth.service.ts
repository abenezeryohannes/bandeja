import { Inject, Injectable, UseInterceptors } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt/dist/jwt.service';
import { TOKEN_REPOSITORY } from 'src/core/constants';
import { WrapperDto } from 'src/core/dto/wrapper.dto';
import { UsersService } from 'src/modules/users/domain/services/users.service';
import { Token } from '../entities/token.entity';
import * as Moment from 'moment';
import { ROLE, UserDto } from 'src/modules/users/infrastructure/dto/user.dto';
import { TransactionInterceptor } from 'src/core/database/decorators/transaction.interceptor';
import { request } from 'http';

@Injectable()
export class AuthService {
  constructor(
    private readonly userService: UsersService,
    private readonly jwtService: JwtService,
    @Inject(TOKEN_REPOSITORY) private readonly tokenRepository: typeof Token,
  ) {}

  @UseInterceptors(TransactionInterceptor)
  public async login(request: any, requestBody: any) {
    if (requestBody.phoneNumber == null || requestBody.UID == null)
      return WrapperDto.error(
        422,
        'UID and Phone Number is required to login!',
      );

    let user = await this.userService.findOneByPhoneNumber(
      requestBody.phoneNumber,
    );
    if (user == null)
      user = await this.userService.create(
        new UserDto({
          phoneNumber: requestBody.phoneNumber,
          UID: requestBody.UID,
          role: requestBody.role,
        }),
        request.transaction,
      );
    // return WrapperDto.error(
    //   404,
    //   'No user registered with this phone number, please try to sign up.',
    // );
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
      await user.save({ transaction: request.transaction });
    }

    const userWithToken = await this.generateToken(
      user['dataValues'],
      requestBody.role,
      request.transaction,
    );

    return userWithToken;
  }

  @UseInterceptors(TransactionInterceptor)
  public async logout(token: Token) {
    if (token != null) {
      await this.tokenRepository.destroy({
        where: { id: token.getDataValue('id') },
      });
    }
    return WrapperDto.successfull('Logout Successfull');
  }

  @UseInterceptors(TransactionInterceptor)
  public async signUp(request: any, user: UserDto) {
    // create the user
    const newUser = await this.userService.create(
      { ...user },
      request.transaction,
    );

    // generate token
    const newUserWIthToken = await this.generateToken(
      newUser['dataValues'],
      newUser.getDataValue('role'),
      request.transaction,
    );

    return newUserWIthToken;
  }

  private async generateToken(user, role: string, transaction: any) {
    const code = await this.jwtService.signAsync(user);
    const token = await this.tokenRepository.create<Token>(
      {
        userId: user.id,
        token: code,
        until: Moment().add(Moment.duration(12, 'months')).toDate(),
        role: role,
      },
      { transaction: transaction },
    );
    const result = await this.userService.findUserWithToken(
      token.getDataValue('userId'),
      token.getDataValue('token'),
    );
    return result;
  }

  async findUser(body: any) {
    const user = await this.userService.findOneByPhoneNumber(
      body['phoneNumber'],
    );
    return user;
  }
}
