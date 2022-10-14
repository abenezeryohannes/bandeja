import { Module, Scope } from '@nestjs/common';
import { APP_INTERCEPTOR } from '@nestjs/core';
import { databaseProviders } from './database.provider';
import { TransactionInterceptor } from './decorators/transaction.interceptor';

@Module({
  providers: [
    ...databaseProviders,
    {
      provide: APP_INTERCEPTOR,
      scope: Scope.REQUEST,
      useClass: TransactionInterceptor,
    },
  ],
  exports: [...databaseProviders],
})
export class DatabaseModule {}
