import {
  BelongsTo,
  Column,
  DataType,
  Default,
  ForeignKey,
  Model,
  Table,
} from 'sequelize-typescript';
import { Post } from './post.entity';

@Table
export class PostImage extends Model {
  @ForeignKey(() => Post)
  @Column({ type: DataType.INTEGER, allowNull: false })
  postId: number;

  @Default(process.env.PLACEHOLDER)
  @Column({ type: DataType.STRING, allowNull: false })
  img: string;

  @BelongsTo(() => Post)
  Post: Post;
}
