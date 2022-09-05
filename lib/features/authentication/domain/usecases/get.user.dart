import 'package:equatable/equatable.dart';
import 'package:app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:app/core/usecases/usecase.dart';
import 'package:app/features/authentication/domain/repositories/user.repository.dart';

import '../entities/user.dart';

class GetUser implements UseCase<User, Params> {
  late UserRepositoy userRepositoy;
  GetUser({required this.userRepositoy});

  @override
  Future<Either<Failure, User>?>? call(param) {
    return userRepositoy.getUser(param.userUid);
  }
}

class Params extends Equatable {
  late String userUid;
  Params({required this.userUid});
  @override
  List<Object?> get props => [userUid];
}
