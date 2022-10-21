import { Controller, Get, Query } from '@nestjs/common';
import { WrapperDto } from '../../../core/dto/wrapper.dto';
import { Roles } from '../../auth/domain/guards/roles.decorator';
import { ROLE } from '../../users/infrastructure/dto/user.dto';
import { PadelGroupService } from '../domain/services/padel_group.service';

@Controller('padel-group')
export class PadelGroupController {
  constructor(private readonly padelGroupsService: PadelGroupService) {}

  @Roles(ROLE.ADMIN, ROLE.OWNER, ROLE.USER)
  @Get()
  async findAll(@Query() query) {
    try {
      const result = await this.padelGroupsService.findAll(query);
      return WrapperDto.paginate(result, query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }
}
