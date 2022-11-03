import {
  BelongsTo,
  Column,
  DataType,
  Default,
  ForeignKey,
  Model,
  Table,
} from 'sequelize-typescript';
import { Padel } from '../../../padels/domain/entities/padel.entity';
import { PadelSchedule } from '../../../padels/domain/entities/padel.schedule.entity';
import { PromoCode } from '../../../padels/domain/entities/promo.code.entity';
import { User } from '../../../users/domain/entities/user.entity';
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

  @Default(0)
  @Column({ type: DataType.DECIMAL(20, 2), allowNull: false })
  amount: number;

  @Column({ type: DataType.STRING, allowNull: true })
  barCode: string;

  @Column({ type: DataType.DATE, allowNull: true })
  paymentDate: Date;

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
