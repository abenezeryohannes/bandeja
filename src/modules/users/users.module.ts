import { Module } from '@nestjs/common';
import { AddressController } from './controllers/address.controller';
import { UsersController } from './controllers/users.controller';
import { AddressService } from './domain/services/address.service';
import { UsersService } from './domain/services/users.service';
import { usersProviders } from './users.providers';
@Module({
  providers: [...usersProviders, UsersService, AddressService],
  exports: [UsersService],
  controllers: [UsersController, AddressController],
})
export class UsersModule {}
