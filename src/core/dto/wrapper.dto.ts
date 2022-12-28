import { HttpException } from '@nestjs/common/exceptions/http.exception';
import { LIMIT } from '../constants';
import { Util } from '../utils/util';

export class WrapperDto {
  statusCode: number;
  success: boolean;
  data: any;
  message: string;
  count: number;
  page: number;
  total_pages: number;
  limit: number;
  sort_by: string;
  sort: string;
  static successfullCreated(data: any): WrapperDto {
    const wrapper = new WrapperDto();
    wrapper.success = true;
    wrapper.statusCode = 201;
    wrapper.data = data;
    return wrapper;
  }
  static successfull(data: any): WrapperDto {
    const wrapper = new WrapperDto();
    wrapper.success = true;
    wrapper.statusCode = 200;
    wrapper.data = data;
    return wrapper;
  }
  static error(statusCode: number, message: string): HttpException {
    const wrapper = new HttpException(message, statusCode);
    return wrapper;
  }
  static paginate(data: any, query: any): WrapperDto {
    const wrapper = new WrapperDto();
    wrapper.page = Number.parseInt(query.page);
    wrapper.page = 0;
    wrapper.limit = Util.getLimit(query);
    wrapper.success = true;
    wrapper.statusCode = 200;
    wrapper.count = data.length;

    wrapper.data = data;

    // wrapper.total_pages = Math.ceil(total_items / wrapper.limit);
    return wrapper;
  }
  static figureOutTheError(error: any) {
    if (error['name'] != null && error['name'].startsWith('Sequelize')) {
      if (error['errors'] != null) {
        return WrapperDto.error(
          422,
          error['errors'].map((e) => e.message).join(' '),
        );
      } else return WrapperDto.error(422, error.message);
    } else if (error['message'] != null) {
      return WrapperDto.error(500, error['message']);
    } else if (Array.isArray(error)) {
      const wrapper = new WrapperDto();
      wrapper.success = false;
      wrapper.statusCode = 422;
      wrapper.message = '';
      error.forEach((err) => {
        const constraints = err['constraints'];
        if (constraints != null) {
          for (const key in constraints) {
            if (constraints[key] != undefined || constraints[key] != null)
              wrapper.message += constraints[key] + ' \n';
          }
        }
      });
      return wrapper;
    }
  }
}
