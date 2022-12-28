import {
  Column,
  DataType,
  Default,
  Model,
  Table,
  Unique,
} from 'sequelize-typescript';

@Table
export class SystemVariable extends Model {
  @Unique
  @Column({ type: DataType.STRING, allowNull: false })
  key: string;

  @Default(false)
  @Column({ type: DataType.STRING })
  value: string;
}
