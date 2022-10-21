import { Module } from '@nestjs/common';
import { UsersModule } from '../users/users.module';
import { JwtModule } from '@nestjs/jwt';
import { GuardsProvider } from './auth.providers';
import { AuthService } from './domain/services/auth.service';
import { AuthController } from './controllers/auth.controller'; 
import { DatabaseModule } from '../../core/database/database.module';
@Module({
  imports: [
    UsersModule,
    DatabaseModule,
    JwtModule.register({
      secret: process.env.JWTKEY,
      signOptions: { expiresIn: process.env.TOKEN_EXPIRATION },
    }),
    // MomentModule.forRoot({ tz: 'UTC' }),
  ],
  providers: [AuthService, ...GuardsProvider],
  controllers: [AuthController],
})
export class AuthModule {}
