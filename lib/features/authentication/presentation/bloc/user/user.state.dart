part of 'user.bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserStateLoading extends UserState {}

class UserStateEmpty extends UserState {}

class UserStateError extends UserState {
  Failure failure;
  UserStateError({required this.failure});
}

class UserStateLoaded extends UserState {
  late User user;
  UserStateLoaded({required this.user});
}

class UserStateVoted extends UserState {
  late User user;
  UserStateVoted({required this.user});
}
