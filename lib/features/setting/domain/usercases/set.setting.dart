import 'package:equatable/equatable.dart';
import 'package:app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:app/core/usecases/usecase.dart';

import '../entities/setting.dart';
import '../repositories/setting.repository.dart';

class SetSetting implements UseCase<Setting, Params> {
  SettingRepository settingRepository;
  SetSetting({required this.settingRepository});
  @override
  Future<Either<Failure, Setting>?>? call(params) {
    return settingRepository.setSetting(params.setting);
  }
}

class Params extends Equatable {
  Setting setting;

  Params({required this.setting});

  @override
  List<Object?> get props => [setting];
}
