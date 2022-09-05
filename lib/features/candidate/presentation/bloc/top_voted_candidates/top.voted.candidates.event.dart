part of 'top.voted.candidates.bloc.dart';

abstract class TopVotedCandidateEvent extends Equatable {
  const TopVotedCandidateEvent();

  @override
  List<Object> get props => [];
}

class GetTopVoteCandidateEvent extends TopVotedCandidateEvent {}

class RefreshTopVoteCandidateEvent extends TopVotedCandidateEvent {}

class LoadTopVoteCandidateEvent extends TopVotedCandidateEvent {}
