import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:app/features/candidate/domain/usecases/get.featured.candidates.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/network/network.info.dart';
import '../../../../../injection.container.dart';
import '../../../domain/entities/candidate.dart';
import '../../../domain/usecases/load.featured.candidates.dart';

part 'featured.candidates.event.dart';
part 'featured.candidates.state.dart';

class FeaturedCandidatesBloc
    extends Bloc<FeaturedCandidatesEvent, FeaturedCandidatesState> {
  late GetFeaturedCandidates getFeaturedCandidates;
  late LoadFeaturedCandidates loadFeaturedCandidates;
  FeaturedCandidatesBloc(
      {required this.getFeaturedCandidates,
      required this.loadFeaturedCandidates})
      : super(FeaturedCandidatesStateEmpty()) {
    on<LoadFeaturedCandidatesEvent>((event, emit) async {
      emit(FeaturedCandidatesStateLoading());
      final cache =
          await loadFeaturedCandidates(LoadFeaturedCandidatesNoParams());
      if (cache != null) {
        final response = cache.fold(
            (l) => FeaturedCandidatesStateError(failure: l),
            (r) => FeaturedCandidatesStateLoaded(candidates: r));
        if (response.runtimeType != FeaturedCandidatesStateError) {
          emit(response);
        } else if (!(await sl<NetworkInfo>().isConnected)) {
          emit(response);
        } else
          add(RefreshFeaturedCandidatesEvent());
      }
    });
    on<GetFeaturedCandidatesEvent>((event, emit) async {
      final result = await getFeaturedCandidates(NoParams());
      if (result == null) return emit(FeaturedCandidatesStateEmpty());
      final response = result.fold(
          (l) => (FeaturedCandidatesStateError(failure: l)),
          (r) => FeaturedCandidatesStateLoaded(candidates: r));
      emit(response);
    });
    on<RefreshFeaturedCandidatesEvent>((event, emit) async {
      emit(FeaturedCandidatesStateLoading());
      final result = await getFeaturedCandidates(NoParams());
      if (result == null) return emit(FeaturedCandidatesStateEmpty());
      final response = result.fold(
          (l) => (FeaturedCandidatesStateError(failure: l)),
          (r) => FeaturedCandidatesStateLoaded(candidates: r));
      emit(response);
    });
  }

  // handleFailure(Failure failure) {
  //   switch (failure.runtimeType) {
  //     case CacheFailure:
  //       return FeaturedCandidatesStateError(message: failure.message);
  //     case ServerFailure:
  //       return FeaturedCandidatesStateError(message: failure.message);
  //     case ClientFailure:
  //       return FeaturedCandidatesStateError(message: failure.message);
  //     case NoDataFailure:
  //       return FeaturedCandidatesStateError(message: failure.message);
  //     default:
  //       return FeaturedCandidatesStateError(message: 'Unexpected Error');
  //   }
  // }
}
