import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/entities/candidate.dart';
import '../../../domain/usecases/get.candidates.under.category.dart';

part 'candidates.under.category.event.dart';
part 'candidates.under.category.state.dart';

class CandidatesUnderCategoryBloc
    extends Bloc<CandidatesUnderCategoryEvent, CandidatesUnderCategoryState> {
  late GetCandidatesUnderCategory getCandidatesUnderCategory;
  CandidatesUnderCategoryBloc({required this.getCandidatesUnderCategory})
      : super(CandidatesUnderCategoryStateEmpty()) {
    on<GetCandidatesUnderCategoryEvent>((event, emit) async {
      emit(CandidatesUnderCategoryStateLoading());
      final result = await getCandidatesUnderCategory(
          Params(categoryId: (event).categoryId));
      if (result == null) return emit(CandidatesUnderCategoryStateEmpty());
      final response = result.fold(
          (l) => CandidatesUnderCategoryStateError(failure: l),
          (r) => CandidatesUnderCategoryStateLoaded(candidates: r));
      emit(response);
    });
  }

  // handleFailure(Failure failure) {
  //   switch (failure.runtimeType) {
  //     case CacheFailure:
  //       return CandidatesUnderCategoryStateError(message: failure.message);
  //     case ServerFailure:
  //       return CandidatesUnderCategoryStateError(message: failure.message);
  //     case ClientFailure:
  //       return CandidatesUnderCategoryStateError(message: failure.message);
  //     case NoDataFailure:
  //       return CandidatesUnderCategoryStateError(message: failure.message);
  //     default:
  //       return CandidatesUnderCategoryStateError(message: 'Unexpected Error');
  //   }
  // }
}
