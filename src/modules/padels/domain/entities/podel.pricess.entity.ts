import {
  Column,
  DataType,
  Default,
  ForeignKey,
  Model,
  Table,
  Unique,
} from 'sequelize-typescript';
import { Padel } from './padel.entity';

@Table
export class PadelPrices extends Model {
  @ForeignKey(() => Padel)
  @Column({ type: DataType.INTEGER, allowNull: false })
  padelId: number;

  @Default(0)
  @Column({ type: DataType.DECIMAL(7, 2), allowNull: false })
  price: number;

  @Column({ type: DataType.DATE, allowNull: false })
  startTime: Date;

  @Column({ type: DataType.DATE, allowNull: false })
  endTime: Date;
}
