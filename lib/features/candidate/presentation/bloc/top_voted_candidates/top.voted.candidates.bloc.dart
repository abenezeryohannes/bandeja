import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:app/core/network/network.info.dart';
import 'package:app/features/candidate/domain/entities/candidate.dart';
import 'package:app/features/candidate/domain/usecases/get.top.voted.candidates.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../injection.container.dart';
import '../../../domain/entities/candidate.dart';
import '../../../domain/usecases/load.top.voted.candidates.dart';

part 'top.voted.candidates.event.dart';
part 'top.voted.candidates.state.dart';

class TopVotedCandidatesBloc
    extends Bloc<TopVotedCandidateEvent, TopVotedCandidateState> {
  late GetTopVotedCandidates getTopVotes;
  // ignore: non_constant_identifier_names
  late LoadTopVotedCandidates LoadTopVotes;
  TopVotedCandidatesBloc(
      {required this.getTopVotes, required this.LoadTopVotes})
      : super(TopVotedStateEmpty()) {
    on<LoadTopVoteCandidateEvent>((event, emit) async {
      emit(TopVotedStateLoading());
      final cache = await LoadTopVotes(LoadTopVotedCandidatesNoParams());
      if (cache != null) {
        final response = cache.fold(
            (l) => TopVotedCandidateStateError(failure: l),
            (r) => TopVotedCandidateStateLoaded(candidates: r));
        if (response.runtimeType != TopVotedCandidateStateError) {
          emit(response);
        } else if (!(await sl<NetworkInfo>().isConnected)) {
          emit(response);
        } else
          add(RefreshTopVoteCandidateEvent());
      }
    });
    on<GetTopVoteCandidateEvent>((event, emit) async {
      final result = (await getTopVotes(NoParams()));
      if (result == null) return emit(TopVotedStateEmpty());
      final response = result.fold(
          (l) => TopVotedCandidateStateError(failure: l),
          (r) => TopVotedCandidateStateLoaded(candidates: r));
      emit(response);
    });
    on<RefreshTopVoteCandidateEvent>((event, emit) async {
      emit(TopVotedStateLoading());
      final result = (await getTopVotes(NoParams()));
      if (result == null) return emit(TopVotedStateEmpty());
      final response = result.fold(
          (l) => TopVotedCandidateStateError(failure: l),
          (r) => TopVotedCandidateStateLoaded(candidates: r));
      emit(response);
    });
  }

  // handleFailure(Failure failure) {
  //   switch (failure.runtimeType) {
  //     case CacheFailure:
  //       return TopVotedCandidateStateError(message: failure.message);
  //     case ServerFailure:
  //       return TopVotedCandidateStateError(message: failure.message);
  //     case ClientFailure:
  //       return TopVotedCandidateStateError(message: failure.message);
  //     case NoDataFailure:
  //       return TopVotedCandidateStateError(message: failure.message);
  //     default:
  //       return TopVotedCandidateStateError(message: 'Unexpected Error');
  //   }
  // }
}
