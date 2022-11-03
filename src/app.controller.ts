import { Controller, Get, Query, Res, StreamableFile } from '@nestjs/common';
import { createReadStream, existsSync } from 'fs';
import { join } from 'path';
import { AppService } from './app.service';
import { Migrate } from './core/database/seeders/migrate';
import { WrapperDto } from './core/dto/wrapper.dto';
import { Util } from './core/utils/util';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get('seed')
  async seed() {
    try {
      await new Migrate().rollback();
      await new Migrate().run();
      return new Migrate().seed();
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Get('media')
  media(@Query() query: any, @Res() res) {
    try {
      if (query.path == null) {
        throw Error('No media path specified!');
      } else if (Util.isValidHttpUrl(query.path)) {
        return res.redirect(query.path);
      } else {
        const path = join(process.cwd(), 'assets', query.path);
        if (!existsSync(path)) throw Error('media not found');
        const file = createReadStream(path);
        return res.type('image/jpg').send(file);
      }
    } catch (error) {
      const file = createReadStream(
        join(process.cwd(), 'assets', 'img', 'placeholder.jpg'),
      );
      return res.type('image/jpg').send(file);
    }
  }
}
