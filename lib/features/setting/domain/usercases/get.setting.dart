import 'package:equatable/equatable.dart';
import 'package:app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:app/core/usecases/usecase.dart';
import 'package:app/features/setting/domain/repositories/setting.repository.dart';

import '../entities/setting.dart';

class GetSetting implements UseCase<Setting, NoParams> {
  SettingRepository settingRepository;
  GetSetting({required this.settingRepository});

  @override
  Future<Either<Failure, Setting>?>? call(noParams) {
    return settingRepository.getSetting();
  }
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
