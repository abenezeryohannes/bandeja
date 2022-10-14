import { Test, TestingModule } from '@nestjs/testing';
import { PadelGroupController } from './padel_group.controller';

describe('PadelGroupController', () => {
  let controller: PadelGroupController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [PadelGroupController],
    }).compile();

    controller = module.get<PadelGroupController>(PadelGroupController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
