import { Column, DataType, Model, Table } from 'sequelize-typescript';

@Table
export class Duration extends Model {
  @Column({ type: DataType.INTEGER, allowNull: false })
  minute: number;
}
