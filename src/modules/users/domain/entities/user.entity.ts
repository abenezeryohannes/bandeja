import {
  BelongsTo,
  BelongsToMany,
  Column,
  DataType,
  Default,
  ForeignKey,
  HasMany,
  HasOne,
  Index,
  Is,
  Model,
  Table,
} from 'sequelize-typescript';
import { Token } from '../../../auth/domain/entities/token.entity';
import { Bookmark } from '../../../padels/domain/entities/bookmark.entity';
import { Padel } from '../../../padels/domain/entities/padel.entity';
import { Notification } from '../../../notifications/domain/entities/notification.entity';
import { Location } from './location.entity';
import { Setting } from './setting.entity';

@Table
export class User extends Model {
  @Column({ type: DataType.STRING, allowNull: true })
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
  @Column({ type: DataType.STRING, allowNull: true })
  phoneNumber: string;

  @Default(true)
  @Column({ type: DataType.BOOLEAN })
  enabled: boolean;

  @HasMany(() => Token)
  Tokens: Token[];

  @HasOne(() => Setting)
  Setting: Setting;

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
