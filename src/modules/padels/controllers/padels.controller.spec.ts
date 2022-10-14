import { Test, TestingModule } from '@nestjs/testing';
import { PadelsController } from './padels.controller';

describe('PadelsController', () => {
  let controller: PadelsController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [PadelsController],
    }).compile();

    controller = module.get<PadelsController>(PadelsController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
