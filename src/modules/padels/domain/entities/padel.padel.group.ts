import {
  BelongsTo,
  Column,
  DataType,
  ForeignKey,
  Model,
  Table,
} from 'sequelize-typescript';
import { Padel } from './padel.entity';
import { PadelGroup } from './padel.group.entity';

@Table
export class PadelPadelGroup extends Model {
  @ForeignKey(() => Padel)
  @Column({ type: DataType.INTEGER, allowNull: false })
  padelId: number;

  @ForeignKey(() => PadelGroup)
  @Column({ type: DataType.INTEGER, allowNull: false })
  padelGroupId: number;

  @BelongsTo(() => PadelGroup)
  PadelGroup: PadelGroup;

  @BelongsTo(() => Padel)
  Padel: Padel;
}
