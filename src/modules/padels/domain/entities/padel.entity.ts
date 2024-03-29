import {
  BelongsTo,
  BelongsToMany,
  Column,
  DataType,
  Default,
  ForeignKey,
  HasMany,
  Model,
  Table,
} from 'sequelize-typescript';
import { Address } from '../../../../modules/users/domain/entities/address.entity';
import { Location } from '../../../../modules/users/domain/entities/location.entity';
import { User } from '../../../../modules/users/domain/entities/user.entity';
import { AppVisit } from '../../../users/domain/entities/app.visit.entity';
import { Bookmark } from './bookmark.entity';
import { Duration } from './duration.entity';
import { Feature } from './feature.entity';
import { PadelFeature } from './padel.feature';
import { PadelGroup } from './padel.group.entity';
import { PadelPadelGroup } from './padel.padel.group';
import { PadelSchedule } from './padel.schedule.entity';

@Table
export class Padel extends Model {
  @ForeignKey(() => User)
  @Column({ type: DataType.INTEGER, allowNull: false })
  userId: number;

  @Column({ type: DataType.STRING, allowNull: false })
  name: string;

  @Column({ type: DataType.STRING })
  banner: string;

  @Column({ type: DataType.STRING })
  avatar: string;

  @ForeignKey(() => Location)
  @Column({ type: DataType.INTEGER })
  locationId: number;

  @ForeignKey(() => Address)
  @Column({ type: DataType.INTEGER })
  addressId: number;

  @Column({ type: DataType.DATE, allowNull: false })
  startTime: Date;

  @Column({ type: DataType.DATE, allowNull: false })
  endTime: Date;

  @ForeignKey(() => Duration)
  @Column({ type: DataType.INTEGER })
  durationId: number;

  @Default(0)
  @Column({ type: DataType.DECIMAL(10, 2), allowNull: false })
  price: number;

  @Default(false)
  @Column({ type: DataType.BOOLEAN })
  indoor: boolean;

  @Default(false)
  @Column({ type: DataType.BOOLEAN })
  approved: boolean;

  @Default(false)
  @Column({ type: DataType.BOOLEAN })
  onlyLadies: boolean;

  @Default(true)
  @Column({ type: DataType.BOOLEAN })
  enabled: boolean;

  @BelongsToMany(() => PadelGroup, () => PadelPadelGroup)
  PadelGroup: PadelGroup;

  @BelongsToMany(() => Feature, () => PadelFeature)
  Features: Feature[];

  @HasMany(() => AppVisit)
  AppVisit: AppVisit;

  @BelongsTo(() => Location)
  Location: Location;

  @BelongsTo(() => Duration)
  Duration: Duration;

  @BelongsTo(() => Address)
  Address: Address;

  @HasMany(() => Bookmark)
  Bookmark: Bookmark;

  @BelongsTo(() => User)
  User: User;

  @HasMany(() => PadelSchedule)
  PadelSchedules: PadelSchedule[];
}
