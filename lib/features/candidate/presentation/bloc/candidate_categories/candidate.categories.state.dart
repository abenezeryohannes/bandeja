part of 'candidate.categories.bloc.dart';

abstract class CandidateCategoriesState extends Equatable {
  const CandidateCategoriesState();

  @override
  List<Object> get props => [];
}

class CandidateCategoriesStateLoading extends CandidateCategoriesState {}

class CandidateCategoriesStateEmpty extends CandidateCategoriesState {}

class CandidateCategoriesStateError extends CandidateCategoriesState {
  Failure failure;
  CandidateCategoriesStateError({required this.failure});
}

class CandidateCategoriesStateLoaded extends CandidateCategoriesState {
  late List<CandidateCategory> candidateCategories;
  CandidateCategoriesStateLoaded({required this.candidateCategories});
}
