import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:app/features/candidate/domain/entities/candidate.category.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/network/network.info.dart';
import '../../../../../injection.container.dart';
import '../../../domain/entities/candidate.category.dart';
import '../../../domain/usecases/get.candidate.categories.dart';
import '../../../domain/usecases/load.candidate.categories.dart';

part 'candidate.categories.event.dart';
part 'candidate.categories.state.dart';

class CandidateCategoriesBloc
    extends Bloc<CandidateCategoriesEvent, CandidateCategoriesState> {
  late GetCandidateCategories getCandidateCategories;
  late LoadCandidateCategories loadCandidateCategories;
  CandidateCategoriesBloc(
      {required this.getCandidateCategories,
      required this.loadCandidateCategories})
      : super(CandidateCategoriesStateEmpty()) {
    on<LoadCandidateCategoriesEvent>((event, emit) async {
      emit(CandidateCategoriesStateLoading());
      final cache =
          await loadCandidateCategories(LoadCandidateCategoriesNoParams());
      if (cache != null) {
        final response = cache.fold(
            (l) => CandidateCategoriesStateError(failure: l),
            (r) => CandidateCategoriesStateLoaded(candidateCategories: r));
        if (response.runtimeType != CandidateCategoriesStateError) {
          emit(response);
        } else if (!(await sl<NetworkInfo>().isConnected)) {
          emit(response);
        } else {
          add(RefreshCandidateCategoriesEvent());
        }
      }
    });
    on<GetCandidateCategoriesEvent>((event, emit) async {
      final result = await getCandidateCategories(NoParams());
      if (result == null) return emit(CandidateCategoriesStateEmpty());
      final response = result.fold(
          (l) => CandidateCategoriesStateError(failure: l),
          (r) => CandidateCategoriesStateLoaded(candidateCategories: r));
      emit(response);
    });
    on<RefreshCandidateCategoriesEvent>((event, emit) async {
      emit(CandidateCategoriesStateLoading());
      final result = await getCandidateCategories(NoParams());
      if (result == null) return emit(CandidateCategoriesStateEmpty());
      final response = result.fold(
          (l) => CandidateCategoriesStateError(failure: l),
          (r) => CandidateCategoriesStateLoaded(candidateCategories: r));
      emit(response);
    });
  }

  // handleFailure(Failure failure) {
  //   switch (failure.runtimeType) {
  //     case CacheFailure:
  //       return CandidateCategoriesStateError(message: failure.message);
  //     case ServerFailure:
  //       return CandidateCategoriesStateError(message: failure.message);
  //     case ClientFailure:
  //       return CandidateCategoriesStateError(message: failure.message);
  //     case NoDataFailure:
  //       return CandidateCategoriesStateError(message: failure.message);
  //     default:
  //       return CandidateCategoriesStateError(message: 'Unexpected Error');
  //   }
  // }
}
