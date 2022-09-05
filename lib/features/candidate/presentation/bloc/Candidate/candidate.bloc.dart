import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:app/features/candidate/domain/usecases/get,candidate.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/entities/candidate.dart';

part 'candidate.event.dart';
part 'candidate.state.dart';

class CandidateBloc extends Bloc<CandidateEvent, CandidateState> {
  GetCandidate getCandidate;
  CandidateBloc({required this.getCandidate}) : super(CandidateStateEmpty()) {
    on<GetCandidateEvent>((event, emit) async {
      emit(CandidateStateLoading());
      final result =
          await getCandidate(GetCandidatParams(id: event.candidateId));
      if (result == null) return emit(CandidateStateEmpty());
      final response = result.fold((l) => CandidateStateError(failure: l),
          (r) => CandidateStateLoaded(candidate: r));
      emit(response);
    });
  }
}
