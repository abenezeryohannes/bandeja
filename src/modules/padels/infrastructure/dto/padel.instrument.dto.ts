import { InstrumentDto } from './instrument.dto';
import { PadelDto } from './padel.dto';
import { IsNotEmpty } from 'class-validator';

export class PadelInstrumentDto {
  readonly id: number;

  @IsNotEmpty({ message: 'Please pick the instrument type!' })
  readonly instrumentId: number;

  readonly padelId: number;

  readonly quantity: number;

  readonly enabled: boolean;

  readonly Instrument: InstrumentDto;

  readonly Padel: PadelDto;
}
