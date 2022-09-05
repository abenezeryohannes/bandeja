import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:app/core/error/failure.dart';
import 'package:app/core/usecases/usecase.dart';
import 'package:app/features/candidate/domain/entities/candidate.dart';
import 'package:app/features/candidate/domain/repositories/candidate.repository.dart';

class GetCandidate implements UseCase<Candidate, GetCandidatParams> {
  late CandidateRepository repository;

  GetCandidate({required this.repository});

  @override
  Future<Either<Failure, Candidate>?>? call(param) async {
    return await repository.getCandidate(param.id);
  }
}

class GetCandidatParams extends Equatable {
  String id;
  GetCandidatParams({required this.id});
  @override
  List<Object?> get props => [];
}
