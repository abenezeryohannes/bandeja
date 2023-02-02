import {
  Column,
  DataType,
  ForeignKey,
  Model,
  BelongsTo,
  Table,
} from 'sequelize-typescript';
import { Padel } from '../../../padels/domain/entities/padel.entity';
import { User } from './user.entity';

@Table
export class AppVisit extends Model {
  @ForeignKey(() => User)
  @Column({ type: DataType.INTEGER, allowNull: false })
  userId: number;

  @ForeignKey(() => Padel)
  @Column({ type: DataType.INTEGER, allowNull: false })
  padelId: number;

  @Column({ type: DataType.DATE, allowNull: false })
  startTime: Date;

  @Column({ type: DataType.DATE, allowNull: false })
  endTime: Date;

  @BelongsTo(() => Padel)
  Padel: Padel;

  @BelongsTo(() => User)
  User: User;

  // @HasOne(() => AppVisit)
  // AppVisit: AppVisit;
}
