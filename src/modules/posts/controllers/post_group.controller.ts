import { Controller, Get, Query } from '@nestjs/common';
import { WrapperDto } from 'src/core/dto/wrapper.dto';
import { Roles } from 'src/modules/auth/domain/guards/roles.decorator';
import { ROLE } from 'src/modules/users/infrastructure/dto/user.dto';
import { PostGroupService } from '../domain/services/post.group.service';

@Controller('postGroups')
export class PostGroupController {
  constructor(private readonly adGroupService: PostGroupService) {}

  @Roles(ROLE.ADMIN, ROLE.OWNER, ROLE.USER)
  @Get()
  async index(@Query() query) {
    try {
      const result = await this.adGroupService.findAll(query);
      return WrapperDto.paginate(result, query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }
}
