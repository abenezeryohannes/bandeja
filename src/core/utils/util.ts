import { LIMIT } from '../constants';

export class Util {
  static getLimit(query: any): number {
    return query.limit == null || query.limit == ''
      ? LIMIT
      : Number.parseInt(query.limit);
  }
  static getOffset(query: any): number {
    return query.page == null || query.page == ''
      ? 0
      : (Number.parseInt(query.page) - 1) * Util.getLimit(query);
  }

  static isValidHttpUrl(val: string) {
    let url;
    try {
      url = new URL(val);
    } catch (_) {
      return false;
    }
    return url.protocol === 'http:' || url.protocol === 'https:';
  }
}
