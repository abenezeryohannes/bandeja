import {
  Column,
  DataType,
  Default,
  ForeignKey,
  Model,
  Table,
} from 'sequelize-typescript';
import { User } from './user.entity';

@Table
export class Setting extends Model {
  @ForeignKey(() => User)
  @Column({ type: DataType.INTEGER, allowNull: false })
  userId: number;

  @Default(false)
  @Column({ type: DataType.BOOLEAN })
  bookingNotification: boolean;

  @Default(false)
  @Column({ type: DataType.BOOLEAN })
  faceId: boolean;
}
