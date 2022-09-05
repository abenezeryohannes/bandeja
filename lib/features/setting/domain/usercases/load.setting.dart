import 'package:equatable/equatable.dart';
import 'package:app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:app/core/usecases/usecase.dart';

import '../entities/setting.dart';
import '../repositories/setting.repository.dart';

class LoadSetting implements UseCase<Setting, NoParams> {
  SettingRepository settingRepository;
  LoadSetting({required this.settingRepository});
  @override
  Future<Either<Failure, Setting>?>? call(noParams) {
    return settingRepository.loadSetting();
  }
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
