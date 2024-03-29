import {
  CallHandler,
  ExecutionContext,
  Inject,
  Injectable,
  NestInterceptor,
} from '@nestjs/common';
import { Observable, throwError } from 'rxjs';
import { catchError, tap } from 'rxjs/operators';
import { Transaction } from 'sequelize';
import { Sequelize } from 'sequelize-typescript';
import { SEQUELIZE } from '../../constants';

@Injectable()
export class TransactionInterceptor implements NestInterceptor {
  constructor(
    @Inject(SEQUELIZE)
    private readonly sequelizeInstance: Sequelize,
  ) {}

  async intercept(
    context: ExecutionContext,
    next: CallHandler,
  ): Promise<Observable<any>> {
    const httpContext = context.switchToHttp();
    const req = httpContext.getRequest();
    const transaction: Transaction = await this.sequelizeInstance.transaction({
      logging: true, // Just for debugging purposes
    });
    req.transaction = transaction;
    return next.handle().pipe(
      tap(async () => {
        try {
          await transaction.commit();
        } catch (e) {}
      }),
      catchError(async (err) => {
        try {
          await transaction.rollback();
        } catch (e) {}
        return throwError(err);
      }),
    );
  }
}
