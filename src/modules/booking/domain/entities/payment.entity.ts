import {
  Column,
  DataType,
  Default,
  ForeignKey,
  HasOne,
  Model,
  Table,
} from 'sequelize-typescript';
import { User } from 'src/modules/users/domain/entities/user.entity';
import { PadelOrder } from './padel.order.entity';

@Table
export class Payment extends Model {
  @ForeignKey(() => User)
  @Column({ type: DataType.INTEGER, allowNull: false })
  userId: number;

  @Default(0)
  @Column({ type: DataType.DECIMAL(10, 2) })
  amount: number;

  // @Default('padel')
  // @Column({ type: DataType.STRING })
  // type: string;

  @Default(true)
  @Column({ type: DataType.BOOLEAN })
  enabled: boolean;

  @HasOne(() => PadelOrder)
  Order: PadelOrder;
}
