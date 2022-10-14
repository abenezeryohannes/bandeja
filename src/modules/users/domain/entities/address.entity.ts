import { Column, DataType, Default, Model, Table } from 'sequelize-typescript';

@Table
export class Address extends Model {
  @Column({ type: DataType.STRING, allowNull: false })
  name: string;

  @Default(true)
  @Column({ type: DataType.BOOLEAN })
  enabled: boolean;
}
