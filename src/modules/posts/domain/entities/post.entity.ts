import {
  BelongsTo,
  Column,
  DataType,
  Default,
  ForeignKey,
  HasMany,
  Model,
  Table,
} from 'sequelize-typescript';
import { PostGroup } from './post.group.entity';
import { User } from 'src/modules/users/domain/entities/user.entity';
import { PostImage } from './post.image.entity';

@Table
export class Post extends Model {
  @ForeignKey(() => User)
  @Column({ type: DataType.INTEGER, allowNull: false })
  userId: number;

  // @Column({ type: DataType.STRING })
  // title: string;

  @Column({ type: DataType.STRING, allowNull: false })
  desc: string;

  @Column({ type: DataType.STRING, allowNull: true })
  whatsApp: string;

  @Column({ type: DataType.STRING, allowNull: true })
  phoneNumber: string;

  @Default(false)
  @Column({ type: DataType.BOOLEAN, allowNull: false })
  featured: boolean;
  // @Default(true)
  // @Column({ type: DataType.BOOLEAN })
  // countable: boolean;

  @Default(true)
  @Column({ type: DataType.BOOLEAN })
  offer: boolean;

  // @Default('pcs')
  // @Column({ type: DataType.STRING })
  // unit: string;

  @ForeignKey(() => PostGroup)
  @Column({ type: DataType.INTEGER, allowNull: false })
  postGroupId: number;

  // @Default(0)
  // @Column({ type: DataType.DECIMAL(10, 2), allowNull: false })
  // quantity: number;

  @Column({ type: DataType.STRING, allowNull: false })
  price: number;

  @Default(true)
  @Column({ type: DataType.BOOLEAN })
  enabled: boolean;

  @BelongsTo(() => PostGroup)
  PostGroup: PostGroup;

  @BelongsTo(() => User)
  User: User;

  @HasMany(() => PostImage)
  PostImages: PostImage[];
}
