import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as FirebaseA;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failure.dart';
import '../../../../candidate/domain/entities/candidate.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/get.user.dart';
import '../../../domain/usecases/set.user.dart';
import '../../../domain/usecases/load.user.dart';
import '../../../domain/usecases/set.user.vote.dart';

part 'user.event.dart';
part 'user.state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  late GetUser getUser;
  late LoadUser loadUser;
  late SetUserVote setUserVote;
  late SetUser setUser;
  UserBloc(
      {required this.getUser,
      required this.setUser,
      required this.loadUser,
      required this.setUserVote})
      : super(UserStateEmpty()) {
    on<LoadUserEvent>((event, emit) async {
      emit(UserStateLoading());
      final result = await loadUser(NoParams());
      if (result == null) return emit(UserStateEmpty());
      final response = result.fold(
          (l) => UserStateError(failure: l), (r) => UserStateLoaded(user: r));
      if (response.runtimeType == UserStateError &&
          (response as UserStateError).failure.runtimeType == NoDataFailure) {
        emit(UserStateEmpty());
      } else {
        emit(response);
      }
    });
    on<GetUserEvent>((event, emit) async {
      emit(UserStateLoading());
      final result = await getUser(Params(userUid: event.uid));
      if (result == null) return emit(UserStateEmpty());
      final response = result.fold(
          (l) => UserStateError(failure: l), (r) => UserStateLoaded(user: r));
      if (response.runtimeType == UserStateError &&
          (response as UserStateError).failure.runtimeType == NoDataFailure) {
        emit(UserStateEmpty());
      } else {
        emit(response);
      }
    });
    on<SetUserVoteEvent>((event, emit) async {
      // emit(SignIn());
      emit(UserStateLoading());
      User myUser = User(
        createdAt: DateTime.now().toString(),
        identifier: event.user.identifier,
        uid: event.user.uid,
        votedFor: event.user.votedFor,
        id: event.user.id,
      );
      final response = await setUserVote(
          SetUserVoteParams(user: myUser, candidate: event.candidate));
      if (response == null) {
        return;
      }
      final result = response.fold(
          (l) => UserStateError(failure: l), (r) => UserStateVoted(user: r));
      emit(result);
    });
    on<SetUserEvent>((event, emit) async {
      // emit(SignIn());
      emit(UserStateLoading());
      User myUser = User(
        createdAt: DateTime.now().toString(),
        identifier: event.user.identifier,
        uid: event.user.uid,
        votedFor: event.user.votedFor,
        id: event.user.id,
      );
      final response = await setUser(SetParams(user: myUser));
      if (response == null) {
        return;
      }
      final result = response.fold((l) => UserStateError(failure: l),
          (r) => UserStateLoaded(user: event.user));
      emit(result);
    });
  }

  // handleFailure(Failure failure) {
  //   switch (failure.runtimeType) {
  //     case CacheFailure:
  //       return UserStateError(failure: failure.message);
  //     case ServerFailure:
  //       return UserStateError(failure: failure.message);
  //     case ClientFailure:
  //       return UserStateError(failure: failure.message);
  //     case NoDataFailure:
  //       return UserStateError(failure: failure.message);
  //     default:
  //       return UserStateError(failure: 'Unexpected Error');
  //   }
  // }
}
