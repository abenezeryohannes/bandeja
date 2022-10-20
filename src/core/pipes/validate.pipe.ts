import {
  Injectable,
  ArgumentMetadata,
  BadRequestException,
  ValidationPipe,
} from '@nestjs/common';
import { WrapperDto } from '../dto/wrapper.dto';

@Injectable()
export class ValidateInputPipe extends ValidationPipe {
  public async transform(value, metadata: ArgumentMetadata) {
    try {
      return await super.transform(value, metadata);
    } catch (e) {
      if (e instanceof BadRequestException) {
        throw WrapperDto.error(422, this.handleError(e.getResponse()));
      }
    }
  }

  private handleError(errors) {
    return errors.message.map((error) => error).join(' ');
  }
}
