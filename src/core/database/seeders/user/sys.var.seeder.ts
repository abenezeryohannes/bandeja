import { SystemVariable } from '../../../../modules/users/domain/entities/system.variable.entity';

export class SeedSysVar {
  async run(): Promise<boolean> {
    const data = [];
    data.push({
      key: 'contact_us',
      value: '+251910406268',
    });
    await SystemVariable.bulkCreate(data);
    return true;
  }

  async clean(): Promise<boolean> {
    await SystemVariable.drop({ cascade: true });
    return true;
  }
}
