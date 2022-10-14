import { Test, TestingModule } from '@nestjs/testing';
import { PadelGroupService } from './padel_group.service';

describe('PadelGroupService', () => {
  let service: PadelGroupService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [PadelGroupService],
    }).compile();

    service = module.get<PadelGroupService>(PadelGroupService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
