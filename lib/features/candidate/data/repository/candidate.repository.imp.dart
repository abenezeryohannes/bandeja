import 'package:app/core/error/exceptions.dart';
import 'package:app/core/network/network.info.dart';
import 'package:app/features/candidate/data/datasource/candidate.local.data.source.dart';
import 'package:app/features/candidate/data/datasource/candidate.remote.data.source.dart';

import 'package:app/core/error/failure.dart';

import 'package:dartz/dartz.dart';
import 'package:app/features/candidate/domain/entities/candidate.category.dart';

import '../../domain/entities/candidate.dart';
import '../../domain/repositories/candidate.repository.dart';
import '../models/candidate.model.dart';

class CandidateRepositoryImp implements CandidateRepository {
  late NetworkInfo networkInfo;
  late CandidateRemoteDataSource remoteDataSource;
  late CandidateLocalDataSource localDataSource;

  CandidateRepositoryImp(
      {required this.networkInfo,
      required this.localDataSource,
      required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Candidate>>?>? getTopVotedCandidates() async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.getTopVoted();
        if (response == null) return null;
        localDataSource.addTopVotedToCache(response);

        response.sort((b, a) => a.votes.compareTo(b.votes));

        if (response == null) return null;

        return Right(
            getTopVotedTop10OnEach(response, getTopVotedCategories(response)));
      } else {
        final result = await localDataSource.loadTopVotedFromCache();

        result?.sort((b, a) => a.votes.compareTo(b.votes));

        if (result == null) return null;

        return Right(
            getTopVotedTop10OnEach(result, getTopVotedCategories(result)));
      }
    } on ServerSideException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on NoDataException catch (e) {
      return Left(NoDataFailure(message: e.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  getTopVotedCategories(List<CandidateModel> candidates) {
    Map<String, int> top10Categories = {};
    candidates.forEach((candidate) {
      if (!top10Categories.keys.contains(candidate.categoryId)) {
        top10Categories[candidate.categoryId] = 0;
      }
    });
    return top10Categories;
  }

  getTopVotedTop10OnEach(
      List<CandidateModel> candidates, Map<String, int> top10Categories) {
    List<Candidate> top10 = [];

    candidates.forEach((category) {
      final val = top10Categories[category.categoryId];
      if (val != null && val < 10) {
        top10Categories[category.categoryId] = val + 1;
        top10.add(category);
      }
    });

    return top10;
  }

  @override
  Future<Either<Failure, List<CandidateCategory>>?>?
      getCandidateCategories() async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.getCategories();
        if (response == null) return null;
        localDataSource.addCandidateCategoriesToCache(response);
        return Right(response);
      } else {
        final result = await localDataSource.loadCandidateCategoriesFromCache();
        if (result == null) return null;
        return Right(result);
      }
    } on ServerSideException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on NoDataException catch (e) {
      return Left(NoDataFailure(message: e.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, List<Candidate>>?>? getCandidateUnderCategory(
      String categoryId) async {
    try {
      if (await networkInfo.isConnected) {
        final response =
            await remoteDataSource.getCandidatesUnderCategory(categoryId);
        if (response == null) return null;
        localDataSource.addCandidatesUnderCategoryToCache(response, categoryId);
        return Right(response);
      } else {
        final result = await localDataSource
            .loadCandidatesUnderCategoryFromCache(categoryId);
        if (result == null) return null;
        return Right(result);
      }
    } on ServerSideException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on NoDataException catch (e) {
      return Left(NoDataFailure(message: e.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Candidate>>?>? getFeaturedCandidates() async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.getFeatured();
        if (response == null) return null;
        localDataSource.addFeaturedCandidateToCache(response);
        response.shuffle();
        return Right(response);
      } else {
        final result = await localDataSource.loadFeaturedCandidateFromCache();
        if (result == null) return null;
        return Right(result);
      }
    } on ServerSideException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on NoDataException catch (e) {
      return Left(NoDataFailure(message: e.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Candidate>?>? getCandidate(String candidateId) async {
    try {
      if (await networkInfo.isConnected) {
        final response = await remoteDataSource.getCandidate(candidateId);
        if (response == null) return null;
        // localDataSource.addCandidate(response);
        return Right(response);
      } else {
        throw NetworkException();
      }
    } on ServerSideException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on NoDataException catch (e) {
      return Left(NoDataFailure(message: e.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CandidateCategory>>?>?
      loadCandidateCategories() async {
    try {
      final result = await localDataSource.loadCandidateCategoriesFromCache();
      if (result == null) {
        throw NetworkException();
      }
      return Right(result);
    } on ServerSideException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on NoDataException catch (e) {
      return Left(NoDataFailure(message: e.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Candidate>>?>? loadFeaturedCandidates() async {
    try {
      final result = await localDataSource.loadFeaturedCandidateFromCache();
      if (result == null) {
        throw CacheException();
      }
      return Right(result);
    } on ServerSideException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on NoDataException catch (e) {
      return Left(NoDataFailure(message: e.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Candidate>>?>? loadTopVotedCandidates() async {
    try {
      final result = await localDataSource.loadTopVotedFromCache();
      if (result == null) {
        throw CacheException();
      }
      return Right(result);
    } on ServerSideException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on NoDataException catch (e) {
      return Left(NoDataFailure(message: e.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
