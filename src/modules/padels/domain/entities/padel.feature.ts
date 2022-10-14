import {
  BelongsTo,
  Column,
  DataType,
  Default,
  ForeignKey,
  Model,
  Table,
} from 'sequelize-typescript';
import { Feature } from './feature.entity';
import { Padel } from './padel.entity';

@Table
export class PadelFeature extends Model {
  @ForeignKey(() => Feature)
  @Column({ type: DataType.INTEGER, allowNull: false })
  featureId: number;

  @ForeignKey(() => Padel)
  @Column({ type: DataType.INTEGER, allowNull: false })
  padelId: number;

  @Default(1)
  @Column({ type: DataType.INTEGER })
  quantity: number;

  @Default(true)
  @Column({ type: DataType.BOOLEAN })
  free: boolean;

  @Default(true)
  @Column({ type: DataType.BOOLEAN })
  enabled: boolean;

  @BelongsTo(() => Feature)
  Feature: Feature;

  @BelongsTo(() => Padel)
  Padel: Padel;
}
