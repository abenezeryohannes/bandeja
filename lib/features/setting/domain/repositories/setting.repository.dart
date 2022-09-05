import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/setting.dart';

abstract class SettingRepository {
  Future<Either<Failure, Setting>>? getSetting();
  Future<Either<Failure, Setting>>? loadSetting();
  Future<Either<Failure, Setting>>? setSetting(Setting setting);
}
