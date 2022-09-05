part of 'candidates.under.category.bloc.dart';

abstract class CandidatesUnderCategoryState extends Equatable {
  const CandidatesUnderCategoryState();

  @override
  List<Object> get props => [];
}

class CandidatesUnderCategoryStateLoading extends CandidatesUnderCategoryState {
}

class CandidatesUnderCategoryStateEmpty extends CandidatesUnderCategoryState {}

class CandidatesUnderCategoryStateError extends CandidatesUnderCategoryState {
  Failure failure;
  CandidatesUnderCategoryStateError({required this.failure});
}

class CandidatesUnderCategoryStateLoaded extends CandidatesUnderCategoryState {
  late List<Candidate> candidates;
  CandidatesUnderCategoryStateLoaded({required this.candidates});
}
