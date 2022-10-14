import {
  Column,
  DataType,
  Default,
  ForeignKey,
  Model,
  Table,
} from 'sequelize-typescript';

@Table
export class Setting extends Model {
  @ForeignKey(() => Setting)
  @Column({ type: DataType.INTEGER, allowNull: false })
  userId: number;

  @Default(true)
  @Column({ type: DataType.BOOLEAN })
  bookingNotification: boolean;

  @Default(true)
  @Column({ type: DataType.BOOLEAN })
  faceId: boolean;
}
