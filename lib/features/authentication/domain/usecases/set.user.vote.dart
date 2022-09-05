import 'package:equatable/equatable.dart';
import 'package:app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:app/core/usecases/usecase.dart';
import 'package:app/features/authentication/domain/repositories/user.repository.dart';

import '../../../candidate/domain/entities/candidate.dart';
import '../entities/user.dart';

class SetUserVote implements UseCase<User, SetUserVoteParams> {
  late UserRepositoy userRepositoy;
  SetUserVote({required this.userRepositoy});

  @override
  Future<Either<Failure, User>?>? call(param) {
    return userRepositoy.setUserVote(param.user, param.candidate);
  }
}

class SetUserVoteParams extends Equatable {
  late User user;
  late Candidate candidate;
  SetUserVoteParams({required this.user, required this.candidate});
  @override
  List<Object?> get props => [user];
}
