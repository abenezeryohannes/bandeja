import { Column, DataType, Default, Model, Table } from 'sequelize-typescript';

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
}
