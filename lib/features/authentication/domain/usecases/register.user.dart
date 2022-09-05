import 'package:equatable/equatable.dart';
import 'package:app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:app/core/usecases/usecase.dart';
import 'package:app/features/authentication/domain/repositories/user.repository.dart';

import '../entities/user.dart';

class RegisterUser implements UseCase<User, SetParams> {
  late UserRepositoy userRepositoy;
  RegisterUser({required this.userRepositoy});

  @override
  Future<Either<Failure, User>?>? call(param) {
    return userRepositoy.registerUser(param.user);
  }
}

class SetParams extends Equatable {
  late User user;
  SetParams({required this.user});
  @override
  List<Object?> get props => [user];
}
