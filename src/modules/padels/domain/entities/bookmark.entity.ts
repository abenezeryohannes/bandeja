import {
  BelongsTo,
  Column,
  DataType,
  ForeignKey,
  Model,
  Table,
} from 'sequelize-typescript';
import { User } from '../../../users/domain/entities/user.entity';
import { Padel } from './padel.entity';

@Table
export class Bookmark extends Model {
  @ForeignKey(() => User)
  @Column({ type: DataType.INTEGER, allowNull: false })
  userId: number;

  @ForeignKey(() => Padel)
  @Column({ type: DataType.INTEGER, allowNull: false })
  padelId: number;

  @BelongsTo(() => Padel)
  Padel: Padel;

  // @HasOne(() => User)
  // User: User;
}
