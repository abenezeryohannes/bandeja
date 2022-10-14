import {
  BelongsTo,
  Column,
  DataType,
  Default,
  ForeignKey,
  Model,
  Table,
} from 'sequelize-typescript';
import { Padel } from 'src/modules/padels/domain/entities/padel.entity';
import { PadelSchedule } from 'src/modules/padels/domain/entities/padel.schedule.entity';
import { PromoCode } from 'src/modules/padels/domain/entities/promo.code.entity';
import { User } from 'src/modules/users/domain/entities/user.entity';
import { Payment } from './payment.entity';

@Table
export class PadelOrder extends Model {
  @ForeignKey(() => User)
  @Column({ type: DataType.INTEGER, allowNull: false })
  userId: number;

  @ForeignKey(() => Padel)
  @Column({ type: DataType.INTEGER, allowNull: false })
  padelId: number;

  @ForeignKey(() => PadelSchedule)
  @Column({ type: DataType.INTEGER, allowNull: false })
  padelScheduleId: number;

  @ForeignKey(() => Payment)
  @Column({ type: DataType.INTEGER, allowNull: true })
  paymentId: number;

  @ForeignKey(() => PromoCode)
  @Column({ type: DataType.INTEGER, allowNull: true })
  promoCodeID: number;

  @Column({ type: DataType.STRING, allowNull: true })
  barCode: string;

  @Column({ type: DataType.STRING, allowNull: false })
  status: string;

  @Default(true)
  @Column({ type: DataType.BOOLEAN })
  enabled: boolean;

  @BelongsTo(() => User)
  User: User;

  @BelongsTo(() => PadelSchedule)
  PadelSchedule: PadelSchedule;

  @BelongsTo(() => Payment)
  Payment: Payment;

  @BelongsTo(() => PromoCode)
  PromoCode: PromoCode;

  @BelongsTo(() => Padel)
  Padel: Padel;
}
