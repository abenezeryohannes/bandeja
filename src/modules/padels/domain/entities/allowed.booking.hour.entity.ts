import {
  Column,
  DataType,
  Default,
  ForeignKey,
  Model,
  Table,
} from 'sequelize-typescript';
import { Padel } from './padel.entity';

@Table
export class AllowedBookingHour extends Model {
  @ForeignKey(() => Padel)
  @Column({ type: DataType.INTEGER, allowNull: false })
  padelId: number;

  @Column({ type: DataType.INTEGER, allowNull: false })
  hour: number;

  @Default(true)
  @Column({ type: DataType.BOOLEAN })
  am: boolean;
}
