part of 'featured.candidates.bloc.dart';

abstract class FeaturedCandidatesState extends Equatable {
  const FeaturedCandidatesState();

  @override
  List<Object> get props => [];
}

class FeaturedCandidatesStateLoading extends FeaturedCandidatesState {}

class FeaturedCandidatesStateEmpty extends FeaturedCandidatesState {}

class FeaturedCandidatesStateError extends FeaturedCandidatesState {
  Failure failure;
  FeaturedCandidatesStateError({required this.failure});
}

class FeaturedCandidatesStateLoaded extends FeaturedCandidatesState {
  late List<Candidate> candidates;
  FeaturedCandidatesStateLoaded({required this.candidates});
}
