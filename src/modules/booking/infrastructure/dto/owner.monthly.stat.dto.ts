import { isNumber } from 'class-validator';

export class OwnerMontlyStatDto {
  totalVisit: number;
  totalHours: number;
  totalincome: number;
  newUserCount: number;
  padelsCount: number;
  appVisitsCount: number;

  constructor(data: any) {
    this.totalHours = isNumber(data.totalHours) ? data.totalHours : 0;
    this.totalVisit = isNumber(data.totalVisit) ? data.totalVisit : 0;
    this.totalincome = isNumber(data.totalincome) ? data.totalincome : 0;
    this.newUserCount = isNumber(data.newUserCount) ? data.newUserCount : 0;
    this.padelsCount = isNumber(data.padelsCount) ? data.padelsCount : 0;
    this.appVisitsCount = isNumber(data.appVisitsCount)
      ? data.appVisitsCount
      : 0;
  }
}
