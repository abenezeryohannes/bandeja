import { Controller, Query, Get, Param } from '@nestjs/common';
import { WrapperDto } from '../../../core/dto/wrapper.dto';
import { Roles } from '../../auth/domain/guards/roles.decorator';
import { AddressService } from '../domain/services/address.service';
import { ROLE } from '../infrastructure/dto/user.dto';

@Controller('addresses')
export class AddressController {
  constructor(private addressService: AddressService) {}

  @Roles(ROLE.ADMIN, ROLE.OWNER, ROLE.USER)
  @Get()
  async findAll(@Query() query) {
    try {
      const result = await this.addressService.findAll(query);
      return WrapperDto.paginate(result, query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN, ROLE.OWNER, ROLE.USER)
  @Get(':id')
  async get(@Param('id') id: number) {
    try {
      const result = await this.addressService.findOne(id);
      return WrapperDto.successfull(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }
}
