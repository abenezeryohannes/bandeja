import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:app/core/error/failure.dart';
import 'package:app/core/usecases/usecase.dart';
import 'package:app/features/candidate/domain/repositories/candidate.repository.dart';

import '../entities/candidate.dart';

class GetFeaturedCandidates implements UseCase<List<Candidate>, NoParams> {
  late CandidateRepository repository;

  GetFeaturedCandidates({required this.repository});

  @override
  Future<Either<Failure, List<Candidate>>?>? call(param) async {
    return await repository.getFeaturedCandidates();
  }
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
