import {
  Column,
  DataType,
  Default,
  HasMany,
  Is,
  Model,
  Table,
} from 'sequelize-typescript';
import { HEX_REGEX } from 'src/core/constants';
import { Post } from './post.entity';

@Table
export class PostGroup extends Model {
  @Column({ type: DataType.STRING, allowNull: false })
  name: string;

  @Column({ type: DataType.STRING, allowNull: true })
  icon: string;

  @Is(function hexColor(value: string): void {
    if (!HEX_REGEX.test(value)) {
      throw new Error(`"${value}" is not a hex color value.`);
    }
  })
  @Default(process.env.ACCENT_COLOR)
  @Column({ type: DataType.STRING })
  color: string;

  @Column({ type: DataType.INTEGER, defaultValue: 1 })
  sequence: number;

  @Default(true)
  @Column({ type: DataType.BOOLEAN })
  enabled: boolean;

  @HasMany(() => Post)
  Posts: Post[];
}
