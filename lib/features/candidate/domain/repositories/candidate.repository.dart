import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/candidate.category.dart';
import '../entities/candidate.dart';

abstract class CandidateRepository {
  Future<Either<Failure, List<Candidate>>?>? loadTopVotedCandidates();
  Future<Either<Failure, List<Candidate>>?>? loadFeaturedCandidates();
  Future<Either<Failure, List<CandidateCategory>>?>? loadCandidateCategories();
  Future<Either<Failure, List<Candidate>>?>? getTopVotedCandidates();
  Future<Either<Failure, List<Candidate>>?>? getFeaturedCandidates();
  Future<Either<Failure, List<CandidateCategory>>?>? getCandidateCategories();
  Future<Either<Failure, List<Candidate>>?>? getCandidateUnderCategory(
      String id);
  Future<Either<Failure, Candidate>?>? getCandidate(String categoryId);
}
