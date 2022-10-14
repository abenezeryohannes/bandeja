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
export class PadelSchedule extends Model {
  @ForeignKey(() => Padel)
  @Column({ type: DataType.INTEGER, allowNull: false })
  padelId: number;

  @Default('open')
  @Column({ type: DataType.STRING, allowNull: false })
  status: string;

  @Default(false)
  @Column({ type: DataType.BOOLEAN, allowNull: false })
  booked: boolean;

  @Column({ type: DataType.DATE })
  startTime: Date;

  @Column({ type: DataType.DATE })
  endTime: Date;
}
