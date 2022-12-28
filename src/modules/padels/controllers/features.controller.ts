import { Body, Request, Query, Controller, Get, Post } from '@nestjs/common';
import { validateOrReject } from 'class-validator';
import { WrapperDto } from '../../../core/dto/wrapper.dto';
import { Roles } from '../../auth/domain/guards/roles.decorator';
import { ROLE } from '../../users/infrastructure/dto/user.dto';
import { FeatureService } from '../domain/services/feature.service';
import { FeatureDto } from '../infrastructure/dto/feature.dto';
import { FeatureEditDto } from '../infrastructure/dto/feature.edit.dto';

@Controller('features')
export class FeaturesController {
  constructor(private readonly featureService: FeatureService) {}

  @Roles(ROLE.ADMIN)
  @Get()
  async findAll(@Query() query) {
    try {
      const result = await this.featureService.findAll(query);
      return WrapperDto.paginate(result, query);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN)
  @Post('edit')
  async edit(@Request() request, @Body() body) {
    try {
      const featureDto = new FeatureEditDto(body);
      await validateOrReject(featureDto);

      const result = await this.featureService.edit(request, featureDto);
      return WrapperDto.successfullCreated(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN)
  @Post('store')
  async store(@Request() request, @Body() body) {
    try {
      const featureDto = new FeatureDto(body);
      await validateOrReject(featureDto);

      const result = await this.featureService.store(request, featureDto);
      return WrapperDto.successfullCreated(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN)
  @Post('delete')
  async delete(@Request() request, @Body() body) {
    try {
      const result = await this.featureService.delete(body.id);
      return WrapperDto.successfull(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }

  @Roles(ROLE.ADMIN)
  @Post('deleteAll')
  async deleteAll(@Request() request, @Body() body) {
    try {
      const result = await this.featureService.deleteAll(JSON.parse(body.ids));
      return WrapperDto.successfull(result);
    } catch (error) {
      return WrapperDto.figureOutTheError(error);
    }
  }
}
