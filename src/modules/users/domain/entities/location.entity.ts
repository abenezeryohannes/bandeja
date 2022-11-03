import { Column, DataType, HasMany, Model, Table } from 'sequelize-typescript';
import { User } from './user.entity';

@Table
export class Location extends Model {
  @Column({ type: DataType.DECIMAL(10, 6), defaultValue: 0 })
  latitude: number;

  @Column({ type: DataType.DECIMAL(10, 6), defaultValue: 0 })
  longitude: number;

  @Column({ type: DataType.STRING, defaultValue: 0 })
  address: string;

  @HasMany(() => User)
  Users: User[];
}
