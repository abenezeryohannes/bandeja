import 'package:equatable/equatable.dart';
import 'package:app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:app/core/usecases/usecase.dart';
import 'package:app/features/authentication/domain/repositories/user.repository.dart';

import '../entities/user.dart';

class LoadUser implements UseCase<User, NoParams> {
  late UserRepositoy userRepositoy;
  LoadUser({required this.userRepositoy});

  @override
  Future<Either<Failure, User>?>? call(noParam) {
    return userRepositoy.loadUser();
  }
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
