import {
  Column,
  DataType,
  Default,
  ForeignKey,
  Model,
  Table,
  IsIn,
  BelongsTo,
} from 'sequelize-typescript';
import { Padel } from './padel.entity';

@Table
export class PadelSchedule extends Model {
  @ForeignKey(() => Padel)
  @Column({ type: DataType.INTEGER, allowNull: false })
  padelId: number;

  @Default('free')
  @IsIn({
    msg: 'Court Schedule status must be either "booked" or "reserverd" or "free"',
    args: [['booked', 'reserved', 'free']],
  })
  @Column({ type: DataType.STRING, allowNull: false })
  status: string;

  @Default(false)
  @Column({ type: DataType.BOOLEAN, allowNull: false })
  booked: boolean;

  @Default(0)
  @Column({ type: DataType.DECIMAL(20, 2), allowNull: false })
  price: number;

  @Column({ type: DataType.DATE })
  startTime: Date;

  @Column({ type: DataType.DATE })
  endTime: Date;

  @BelongsTo(() => Padel)
  Padel: Padel;
}
