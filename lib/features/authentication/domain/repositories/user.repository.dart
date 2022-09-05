import 'package:dartz/dartz.dart';
import 'package:app/features/candidate/domain/entities/candidate.dart';

import '../../../../core/error/failure.dart';
import '../entities/user.dart';

abstract class UserRepositoy {
  Future<Either<Failure, User>> getUser(String uid);
  Future<Either<Failure, User>> loadUser();
  Future<Either<Failure, User>> registerUser(User user);
  Future<Either<Failure, User>> setUser(User user);
  Future<Either<Failure, User>> setUserVote(User user, Candidate candidate);
}
