import {
  Column,
  DataType,
  Default,
  ForeignKey,
  BelongsTo,
  Model,
  HasOne,
  Table,
} from 'sequelize-typescript';
import { User } from '../../../users/domain/entities/user.entity';
import { PadelOrder } from './padel.order.entity';

@Table
export class Payment extends Model {
  @ForeignKey(() => User)
  @Column({ type: DataType.INTEGER, allowNull: false })
  userId: number;

  @Default(0)
  @Column({ type: DataType.DECIMAL(10, 2) })
  amount: number;

  @Column({ type: DataType.STRING })
  paymentID: string;

  @Column({ type: DataType.STRING })
  tranID: string;

  @Column({ type: DataType.STRING })
  trackID: string;

  @Column({ type: DataType.STRING })
  postDate: string;

  @Column({ type: DataType.STRING })
  ref: string;

  @Column({ type: DataType.STRING })
  auth: string;

  @Default('unknown')
  @Column({ type: DataType.STRING })
  paymentType: string;

  @Column({ type: DataType.STRING })
  status: string;

  @HasOne(() => PadelOrder)
  PadelOrder: PadelOrder;

  @BelongsTo(() => User)
  User: User;
}
