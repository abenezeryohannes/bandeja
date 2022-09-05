import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:app/core/error/failure.dart';
import 'package:app/core/usecases/usecase.dart';
import 'package:app/features/candidate/domain/entities/candidate.category.dart';
import 'package:app/features/candidate/domain/repositories/candidate.repository.dart';

class LoadCandidateCategories
    implements
        UseCase<List<CandidateCategory>, LoadCandidateCategoriesNoParams> {
  late CandidateRepository repository;

  LoadCandidateCategories({required this.repository});

  @override
  Future<Either<Failure, List<CandidateCategory>>?>? call(param) async {
    return await repository.loadCandidateCategories();
  }
}

class LoadCandidateCategoriesNoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
