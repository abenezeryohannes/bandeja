part of 'candidate.bloc.dart';

abstract class CandidateEvent extends Equatable {
  const CandidateEvent();

  @override
  List<Object> get props => [];
}

class GetCandidateEvent extends CandidateEvent {
  String candidateId;
  GetCandidateEvent({required this.candidateId});
}
