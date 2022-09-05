part of 'candidates.under.category.bloc.dart';

abstract class CandidatesUnderCategoryEvent extends Equatable {
  const CandidatesUnderCategoryEvent();

  @override
  List<Object> get props => [];
}

class GetCandidatesUnderCategoryEvent extends CandidatesUnderCategoryEvent {
  late String categoryId;
  GetCandidatesUnderCategoryEvent({required this.categoryId});
}
