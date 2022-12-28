import {
  Controller,
  Query,
  Get,
  Request,
  Param,
  Post,
  Body,
} from '@nestjs/common';
import { validateOrReject } from 'class-validator';
import { WrapperDto } from '../../../core/dto/wrapper.dto';
import { Roles } from '../../auth/domain/guards/roles.decorator';
import { AddressService } from '../domain/services/address.service';
import { AddressDto } from '../infrastructure/dto/address.dto';
import { AddressEditDto } from '../infrastructure/dto/address.edit.dto';
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

  @Roles(ROLE.ADMIN)
  @Post('edit')
  async edit(@Request() request, @Body() body) {
    try {
      const addressDto = new AddressEditDto(body);
      await validateOrReject(addressDto);

      const result = await this.addressService.edit(request, addressDto);
      return WrapperDto.paginate(result, body);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }
  @Roles(ROLE.ADMIN)
  @Post('store')
  async store(@Request() request, @Body() body) {
    try {
      const addressDto = new AddressDto(body);
      await validateOrReject(addressDto);

      const result = await this.addressService.store(request, addressDto);
      return WrapperDto.paginate(result, body);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN)
  @Post('delete')
  async delete(@Request() request, @Body() body) {
    try {
      const result = await this.addressService.delete(body.id);
      return WrapperDto.successfull(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN)
  @Post('deleteAll')
  async deleteAll(@Request() request, @Body() body) {
    try {
      const result = await this.addressService.deleteAll(JSON.parse(body.ids));
      return WrapperDto.successfull(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }
}
