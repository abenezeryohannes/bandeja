import {
  BelongsToMany,
  Column,
  DataType,
  Default,
  Model,
  Table,
} from 'sequelize-typescript';
import { Padel } from './padel.entity';
import { PadelFeature } from './padel.feature';

@Table
export class Feature extends Model {
  @Column({ type: DataType.STRING, allowNull: false })
  name: string;

  @Default(process.env.PLACEHOLDER)
  @Column({ type: DataType.STRING, allowNull: true })
  icon: string;

  @Default(true)
  @Column({ type: DataType.BOOLEAN })
  enabled: boolean;

  @BelongsToMany(() => Padel, () => PadelFeature)
  Padels: Padel[];
}
