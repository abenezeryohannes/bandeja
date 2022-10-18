import {
  BelongsTo,
  Column,
  DataType,
  Default,
  ForeignKey,
  Is,
  Model,
  Table,
} from 'sequelize-typescript';
import { User } from '../../../users/domain/entities/user.entity';

@Table
export class Token extends Model {
  @ForeignKey(() => User)
  @Column({ type: DataType.INTEGER })
  userId: number;

  @Default('user')
  @Column({ type: DataType.STRING, allowNull: false })
  token: string;

  @Column({ type: DataType.STRING, allowNull: true })
  fcmTOken: string;

  @Is(function roleType(value: string): void {
    if (!['user', 'admin', 'owner'].includes(value)) {
      throw new Error(`"${value}" is not one of user or admin or owner.`);
    }
  })
  @Column({
    type: DataType.STRING,
    defaultValue: 'user',
  })
  role: string;

  @Column({
    type: DataType.DATEONLY,
    allowNull: false,
  })
  until: Date;

  @BelongsTo(() => User)
  User: User;
}
