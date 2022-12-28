import {
  BelongsTo,
  Column,
  DataType,
  ForeignKey,
  Model,
  Table,
  Default,
} from 'sequelize-typescript';
import { User } from '../../../users/domain/entities/user.entity';

@Table
export class Ad extends Model {
  @ForeignKey(() => User)
  @Column({ type: DataType.INTEGER })
  userId: number;

  @Column({ type: DataType.STRING, allowNull: false })
  banner: string;

  @Column({ type: DataType.STRING, allowNull: true })
  link: string;

  @Default(true)
  @Column({ type: DataType.BOOLEAN })
  enabled: boolean;

  @BelongsTo(() => User)
  User: User;
}
