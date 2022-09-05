part of 'featured.candidates.bloc.dart';

abstract class FeaturedCandidatesEvent extends Equatable {
  const FeaturedCandidatesEvent();

  @override
  List<Object> get props => [];
}

class GetFeaturedCandidatesEvent extends FeaturedCandidatesEvent {}

class LoadFeaturedCandidatesEvent extends FeaturedCandidatesEvent {}

class RefreshFeaturedCandidatesEvent extends FeaturedCandidatesEvent {}
