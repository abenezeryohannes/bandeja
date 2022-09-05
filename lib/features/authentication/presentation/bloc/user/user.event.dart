part of 'user.bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetUserEvent extends UserEvent {
  late String uid;
  GetUserEvent({required this.uid});
}

class LoadUserEvent extends UserEvent {}

class SetUserEvent extends UserEvent {
  late User user;
  SetUserEvent({required this.user});
}

class SetUserVoteEvent extends UserEvent {
  late User user;
  late Candidate candidate;
  SetUserVoteEvent({required this.candidate, required this.user});
}
