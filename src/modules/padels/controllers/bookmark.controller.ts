import {
  Body,
  Controller,
  Get,
  Param,
  Post,
  Query,
  Request,
} from '@nestjs/common';
import { WrapperDto } from '../../../core/dto/wrapper.dto';
import { Roles } from '../../auth/domain/guards/roles.decorator';
import { ROLE } from '../../users/infrastructure/dto/user.dto';
import { BookmarkService } from '../domain/services/bookmark.service';
import { BookmarkDto } from '../infrastructure/dto/bookmark.dto';

@Controller('bookmarks')
export class BookmarkController {
  constructor(private bookmarkService: BookmarkService) {}

  @Roles(ROLE.USER)
  @Get()
  async findAll(@Query() query, @Request() request) {
    try {
      const result = await this.bookmarkService.findAll(request.user, query);
      return WrapperDto.paginate(result, query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.USER)
  @Get(':id')
  async findOne(@Param() id: number) {
    try {
      const result = await this.bookmarkService.findOne(id);
      return WrapperDto.successfull(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.USER)
  @Post('set')
  async set(@Request() request, @Body() bookmarkDto: BookmarkDto) {
    try {
      const result = await this.bookmarkService.set(request.user, bookmarkDto);
      return WrapperDto.successfull(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }
}
