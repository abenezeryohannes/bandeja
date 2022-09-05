import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:app/core/error/failure.dart';
import 'package:app/core/usecases/usecase.dart';
import 'package:app/features/candidate/domain/repositories/candidate.repository.dart';

import '../entities/candidate.dart';

class GetCandidatesUnderCategory implements UseCase<List<Candidate>, Params> {
  late CandidateRepository repository;

  GetCandidatesUnderCategory({required this.repository});

  @override
  Future<Either<Failure, List<Candidate>>?>? call(param) async {
    return await repository.getCandidateUnderCategory(param.categoryId);
  }
}

class Params extends Equatable {
  late String categoryId;
  Params({required this.categoryId});
  @override
  List<Object?> get props => [];
}
