import { Test, TestingModule } from '@nestjs/testing';
import { PadelsService } from './padels.service';

describe('PadelsService', () => {
  let service: PadelsService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [PadelsService],
    }).compile();

    service = module.get<PadelsService>(PadelsService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
