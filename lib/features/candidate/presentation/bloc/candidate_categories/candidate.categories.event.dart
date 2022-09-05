part of 'candidate.categories.bloc.dart';

abstract class CandidateCategoriesEvent extends Equatable {
  const CandidateCategoriesEvent();

  @override
  List<Object> get props => [];
}

class GetCandidateCategoriesEvent extends CandidateCategoriesEvent {}

class RefreshCandidateCategoriesEvent extends CandidateCategoriesEvent {}

class LoadCandidateCategoriesEvent extends CandidateCategoriesEvent {}
