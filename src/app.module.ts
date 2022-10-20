import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { ConfigModule } from '@nestjs/config';
import { DatabaseModule } from './core/database/database.module';
import { UsersModule } from './modules/users/users.module';
import { AuthModule } from './modules/auth/auth.module';
import { PadelsModule } from './modules/padels/padels.module';
import { BookingModule } from './modules/booking/booking.module';
import { NotificationsModule } from './modules/notifications/notifications.module';
import { PostsModule } from './modules/posts/posts.module';
import { AppProviders } from './app.providers';
import 'reflect-metadata';
@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true }),
    UsersModule,
    DatabaseModule,
    AuthModule,
    PadelsModule,
    BookingModule,
    NotificationsModule,
    PostsModule,
  ],
  controllers: [AppController],
  providers: [AppService, ...AppProviders],
})
export class AppModule {}
