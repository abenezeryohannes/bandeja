import {
  Column,
  DataType,
  Default,
  HasMany,
  Model,
  Table,
} from 'sequelize-typescript';
import { Padel } from '../../../padels/domain/entities/padel.entity';

@Table
export class Address extends Model {
  @Column({ type: DataType.STRING, allowNull: false })
  name: string;

  @Default(true)
  @Column({ type: DataType.BOOLEAN })
  enabled: boolean;

  @HasMany(() => Padel)
  Padels: Padel[];
}
