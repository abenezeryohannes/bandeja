import { Inject, Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt/dist/jwt.service';
import { Token } from '../entities/token.entity';
import * as Moment from 'moment';
import { TOKEN_REPOSITORY } from '../../../../core/constants';
import { UsersService } from '../../../users/domain/services/users.service';
import { WrapperDto } from '../../../../core/dto/wrapper.dto';
import { ROLE, UserDto } from '../../../users/infrastructure/dto/user.dto';
import { User } from '../../../users/domain/entities/user.entity';
import { Op } from 'sequelize';

@Injectable()
export class AuthService {
  constructor(
    private readonly userService: UsersService,
    private readonly jwtService: JwtService,
    @Inject(TOKEN_REPOSITORY) private readonly tokenRepository: typeof Token,
  ) {}

  public async login(request: any, requestBody: any) {
    if (
      !(requestBody.phoneNumber != null && requestBody.UID != null) &&
      !(requestBody.emailAddress != null && requestBody.password != null)
    )
      throw Error('UID and Phone Number is required to login!');
    let user = null;
    if (requestBody.phoneNumber != null && requestBody.UID != null) {
      user = await this.userService.findOneByPhoneNumber(
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
      if (user.getDataValue('UID') != requestBody.UID)
        throw Error('Incorrect UID, please confirm your phone number first!');
    } else {
      user = await this.userService.findOneByEmail(requestBody.emailAddress);
      if (user == null || user.getDataValue('password') != requestBody.password)
        throw Error('Sorry, No user found with this credential!');
    }

    if (requestBody.role == null) {
      throw Error('Role is not provided');
    }
    if (
      (user.getDataValue('role') != ROLE.ADMIN &&
        requestBody.role == ROLE.ADMIN) ||
      (user.getDataValue('role') != ROLE.OWNER &&
        user.getDataValue('role') != ROLE.ADMIN &&
        requestBody.role == ROLE.OWNER)
    ) {
      throw Error(
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

  public async logout(token: Token) {
    if (token != null) {
      await this.tokenRepository.destroy({
        where: { id: token.getDataValue('id') },
      });
    }
    return WrapperDto.successfull('Logout Successfull');
  }

  public async signUp(request: any, user: UserDto) {
    // create the user
    const newUser = await this.userService.create(
      {
        ...user,
        phoneNumber: user.phoneNumber == undefined ? null : user.phoneNumber,
        enabled: user.role == ROLE.OWNER ? true : true,
      },
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

  private async generateToken(user: any, role: string, transaction: any) {
    const code = await this.jwtService.signAsync(user);
    const token = await this.tokenRepository.create<Token>(
      {
        userId: user.id,
        token: code.substring(0, 254),
        until: Moment().add(Moment.duration(12, 'months')).toDate(),
        role: role,
      },
      { transaction: transaction },
    );
    // const result = await this.userService.findUserWithToken(
    //   token.getDataValue('userId'),
    //   token.getDataValue('token'),
    // );
    user.Token = token;
    return user;
  }

  async updateFCM(request: any): Promise<User> {
    if (request.body.fcm == null || request.body.fcm == undefined)
      throw Error('No FCM provided!');
    request.token.fcmToken = request.body.fcm;
    request.token = await request.token.save();
    request.user.Token = request.token;
    return request.user;
  }

  async findTokens(userId: number) {
    const tokens = await this.tokenRepository.findAll({
      attributes: [['fcmToken', 'fcmToken']],
      where: { userId: userId, fcmToken: { [Op.ne]: null } },
    });
    return tokens;
  }

  async findTokensByRole(role: string) {
    const tokens = await this.tokenRepository.findAll({
      attributes: [['fcmToken', 'fcmToken']],
      where: {
        role: role == null || role == undefined ? { [Op.ne]: null } : role,
        fcmToken: { [Op.ne]: null },
      },
    });
    return tokens;
  }

  async findUser(body: any) {
    const user = await this.userService.findOneByPhoneNumber(
      body['phoneNumber'],
    );
    return user;
  }
}
