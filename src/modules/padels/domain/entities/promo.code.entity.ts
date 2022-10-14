import {
  Column,
  DataType,
  Default,
  ForeignKey,
  Model,
  Table,
  Unique,
} from 'sequelize-typescript';
import { User } from 'src/modules/users/domain/entities/user.entity';
import { Padel } from './padel.entity';

@Table
export class PromoCode extends Model {
  @ForeignKey(() => User)
  @Column({ type: DataType.INTEGER, allowNull: false })
  userId: number;

  @ForeignKey(() => Padel)
  @Column({ type: DataType.INTEGER, allowNull: false })
  padelId: number;

  @Unique
  @Column({ type: DataType.STRING, allowNull: false })
  code: string;

  @Default(0)
  @Column({ type: DataType.INTEGER })
  maxBooking: number;

  @Default(0)
  @Column({ type: DataType.INTEGER })
  leftForBooking: number;
}
