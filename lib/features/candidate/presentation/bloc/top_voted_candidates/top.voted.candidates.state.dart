part of 'top.voted.candidates.bloc.dart';

abstract class TopVotedCandidateState extends Equatable {
  const TopVotedCandidateState();
  @override
  List<Object> get props => [];
}

class TopVotedStateLoading extends TopVotedCandidateState {}

class TopVotedStateEmpty extends TopVotedCandidateState {}

class TopVotedCandidateStateError extends TopVotedCandidateState {
  Failure failure;
  TopVotedCandidateStateError({required this.failure});
}

class TopVotedCandidateStateLoaded extends TopVotedCandidateState {
  late List<Candidate> candidates;
  TopVotedCandidateStateLoaded({required this.candidates});
}
