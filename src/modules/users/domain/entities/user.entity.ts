import {
  BelongsTo,
  BelongsToMany,
  Column,
  DataType,
  Default,
  ForeignKey,
  HasMany,
  Index,
  Is,
  Model,
  Table,
} from 'sequelize-typescript';
import { Notification } from 'src/modules/notifications/domain/entities/notification.entity';
import { Bookmark } from 'src/modules/padels/domain/entities/bookmark.entity';
import { Padel } from 'src/modules/padels/domain/entities/padel.entity';
import { Token } from '../../../auth/domain/entities/token.entity';
import { Location } from './location.entity';

@Table
export class User extends Model {
  @Column({ type: DataType.STRING, allowNull: false })
  fullName: string;

  @Column({
    type: DataType.STRING,
    allowNull: true,
  })
  avatar: string;

  @Index({
    name: 'UID_INDEX',
    type: 'UNIQUE',
    unique: true,
  })
  @Column({
    type: DataType.STRING,
    allowNull: false,
  })
  UID: string;

  @Column({
    type: DataType.STRING,
    allowNull: true,
  })
  emailAddress: string;

  @Column({
    type: DataType.STRING,
    allowNull: true,
  })
  password: string;

  @Default('user')
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

  @ForeignKey(() => Location)
  @Column({
    type: DataType.INTEGER,
    allowNull: true,
  })
  locationId: number;

  @Index({
    name: 'phone-number',
    type: 'UNIQUE',
    unique: true,
  })
  @Column({ type: DataType.STRING, allowNull: false })
  phoneNumber: string;

  @Default(true)
  @Column({ type: DataType.BOOLEAN })
  enabled: boolean;

  @HasMany(() => Token)
  Tokens: Token[];

  Token: Token;

  @HasMany(() => Notification)
  Notifications: Notification[];

  @BelongsTo(() => Location)
  Location: Location;

  @BelongsToMany(() => Padel, () => Bookmark)
  Bookmarks: Padel[];

  @HasMany(() => Padel, {})
  Padels: Padel[];
}
