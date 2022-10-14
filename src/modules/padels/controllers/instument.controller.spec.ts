import { Test, TestingModule } from '@nestjs/testing';
import { InstumentController } from './instument.controller';

describe('InstumentController', () => {
  let controller: InstumentController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [InstumentController],
    }).compile();

    controller = module.get<InstumentController>(InstumentController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
