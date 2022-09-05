import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:app/core/error/failure.dart';
import 'package:app/core/usecases/usecase.dart';
import 'package:app/features/candidate/domain/entities/candidate.category.dart';
import 'package:app/features/candidate/domain/repositories/candidate.repository.dart';

class GetCandidateCategories
    implements UseCase<List<CandidateCategory>, NoParams> {
  late CandidateRepository repository;

  GetCandidateCategories({required this.repository});

  @override
  Future<Either<Failure, List<CandidateCategory>>?>? call(param) async {
    return await repository.getCandidateCategories();
  }
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
