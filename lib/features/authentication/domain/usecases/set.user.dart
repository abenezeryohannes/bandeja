import 'package:equatable/equatable.dart';
import 'package:app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:app/core/usecases/usecase.dart';
import 'package:app/features/authentication/domain/repositories/user.repository.dart';

import '../entities/user.dart';

class SetUser implements UseCase<User, SetParams> {
  late UserRepositoy userRepositoy;
  SetUser({required this.userRepositoy});

  @override
  Future<Either<Failure, User>?>? call(param) {
    return userRepositoy.setUser(param.user);
  }
}

class SetParams extends Equatable {
  late User user;
  SetParams({required this.user});
  @override
  List<Object?> get props => [user];
}
