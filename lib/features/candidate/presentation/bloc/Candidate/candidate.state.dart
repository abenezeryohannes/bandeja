part of 'candidate.bloc.dart';

abstract class CandidateState extends Equatable {
  const CandidateState();

  @override
  List<Object> get props => [];
}

class CandidateStateLoading extends CandidateState {}

class CandidateStateEmpty extends CandidateState {}

class CandidateStateError extends CandidateState {
  Failure failure;
  CandidateStateError({required this.failure});
}

class CandidateStateLoaded extends CandidateState {
  late Candidate candidate;
  CandidateStateLoaded({required this.candidate});
}
