import { Inject, Injectable } from '@nestjs/common';
import { NOTIFICATION_REPOSITORY } from '../../../../core/constants';
import { Util } from '../../../../core/utils/util';
import { User } from '../../../users/domain/entities/user.entity';
import { Notification } from '../../../notifications/domain/entities/notification.entity';
import { seenDto } from '../../infrastructure/dto/seen.dto';
import { NotificationDto } from '../../infrastructure/dto/notification.dto';
import { UsersService } from '../../../users/domain/services/users.service';
import * as firebase from 'firebase-admin';
import { BatchResponse } from 'firebase-admin/lib/messaging/messaging-api';
import { chunk } from 'lodash';
import * as shell from 'shelljs';
import { mapLimit } from 'async';
import { AuthService } from '../../../auth/domain/services/auth.service';
import * as adminConfig from '../../../../flutter-push-notification-config.json';
import { ServiceAccount } from 'firebase-admin';

@Injectable()
export class NotificationsService {
  constructor(
    @Inject(NOTIFICATION_REPOSITORY)
    private readonly notificationRepository: typeof Notification,
    private readonly userService: UsersService,
    private readonly authService: AuthService,
  ) {
    // Set the config options
    // const adminConfig: ServiceAccount = {
    //   projectId: process.env.FIREBASE_PROJECT_ID,
    //   privateKey: process.env.FIREBASE_PRIVATE_KEY.replace(/\\n/gm, '\n'),
    //   clientEmail: process.env.FIREBASE_CLIENT_EMAIL,
    // };
    //
    firebase.initializeApp({
      credential: firebase.credential.cert(adminConfig as ServiceAccount),
      // databaseURL: process.env.FIREBASE_DATABASE_URL,
    });
  }

  async findAll(user: User, query: any): Promise<Notification[]> {
    return await this.notificationRepository.findAll({
      where: { userId: user.id },
      limit: Util.getLimit(query),
      offset: Util.getOffset(query),
    });
  }

  async findAllUnseen(user: User, query: any): Promise<Notification[]> {
    return await this.notificationRepository.findAll({
      where: { userId: user.id, seen: false },
      limit: Util.getLimit(query),
      offset: Util.getOffset(query),
    });
  }

  async unseenCount(request: any): Promise<number> {
    const counted = await this.notificationRepository.count({
      where: { seen: false, userId: request.user.id },
    });
    return counted;
  }

  async seen(request: any, seen: seenDto): Promise<Notification> {
    const notification = await this.notificationRepository.findByPk(
      seen.notificationId,
    );
    notification.seen = true;
    return await notification.save({ transaction: request.transaction });
  }
  async clear(request: any): Promise<Notification[]> {
    await this.notificationRepository.destroy({
      where: { userID: request.user.id },
      transaction: request.transaction,
    });
    return await this.notificationRepository.findAll({
      where: { userId: request.user.id },
    });
  }

  async add(
    request: any,
    notificationDto: NotificationDto,
  ): Promise<Notification> {
    return await this.notificationRepository.create(
      {
        userID: notificationDto.userId,
        title: notificationDto.title,
        desc: notificationDto.desc,
        seen: notificationDto.seen,
      },
      { transaction: request.transaction },
    );
  }

  async addAll(
    request: any,
    notificationDto: NotificationDto,
  ): Promise<boolean> {
    if (notificationDto.role == null) return null;
    const usersIds = await this.userService.findAllUserIds(
      notificationDto.role,
    );
    const data = [];
    usersIds.forEach((id) => {
      data.push({
        userID: id,
        title: notificationDto.title,
        desc: notificationDto.desc,
        seen: notificationDto.seen,
      });
    });
    await this.notificationRepository.bulkCreate(data, {
      transaction: request.transaction,
    });
    return true;
  }

  public async SendMessage(
    request: any,
    notificationDto: NotificationDto,
    save: boolean,
  ): Promise<any> {
    const tokens =
      notificationDto.userId != null
        ? await this.authService.findTokens(notificationDto.userId)
        : await this.authService.findTokensByRole(notificationDto.role);

    const messages = tokens.map(
      (t) =>
        new NotificationDto({
          fcm: t.fcmToken,
          title: notificationDto.title,
          desc: notificationDto.desc,
          seen: notificationDto.seen,
        }),
    );
    //const response: BatchResponse =
    //const response =
    await this.sendFirebaseMessages(messages, false);

    if (save || save == null) {
      await this.addAll(request, notificationDto);
    }
    // return {
    //   failureCount: response[0].failureCount,
    //   successCount: response[0].successCount,
    // };
    return true;
  }

  public async sendFirebaseMessages(
    firebaseMessages: NotificationDto[],
    dryRun?: boolean,
  ): Promise<BatchResponse> {
    const batchedFirebaseMessages = chunk(firebaseMessages, 500);

    const batchResponses = await mapLimit<NotificationDto[], BatchResponse>(
      batchedFirebaseMessages,
      process.env.FIREBASE_PARALLEL_LIMIT || 3, // 3 is a good place to start
      async (
        groupedFirebaseMessages: NotificationDto[],
      ): Promise<BatchResponse> => {
        try {
          const tokenMessages: firebase.messaging.TokenMessage[] =
            groupedFirebaseMessages.map(({ desc, title, token }) => ({
              notification: { title: title, body: desc },
              android: {
                notification: {
                  title: title,
                  body: desc,
                },
                priority: 'high',
              },
              token: token,
              apns: {
                payload: {
                  aps: {
                    'content-available': 1,
                  },
                },
              },
            }));

          return await this.sendAll(tokenMessages, dryRun);
        } catch (error) {
          return {
            responses: groupedFirebaseMessages.map(() => ({
              success: false,
              error,
            })),
            successCount: 0,
            failureCount: groupedFirebaseMessages.length,
          };
        }
      },
    );

    return batchResponses.reduce(
      ({ responses, successCount, failureCount }, currentResponse) => {
        return {
          responses: responses.concat(currentResponse.responses),
          successCount: successCount + currentResponse.successCount,
          failureCount: failureCount + currentResponse.failureCount,
        };
      },
      {
        responses: [],
        successCount: 0,
        failureCount: 0,
      } as unknown as BatchResponse,
    );
  }

  public async sendAll(
    messages: firebase.messaging.TokenMessage[],
    dryRun?: boolean,
  ): Promise<BatchResponse> {
    if (process.env.ENV === 'DEV') {
      for (const { notification, token } of messages) {
        shell.exec(
          `echo '{ "aps": { "alert": ${JSON.stringify(
            notification,
          )}, "token": "${token}" } }' | xcrun simctl push booted com.konrad.bandeja -`,
        );
      }
    }
    return firebase.messaging().sendAll(messages, dryRun);
  }
}
