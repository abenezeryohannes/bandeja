part of 'setting.bloc.dart';

abstract class SettingState extends Equatable {
  const SettingState();

  @override
  List<Object> get props => [];
}

class SettingStateLoading extends SettingState {}

class SettingStateEmpty extends SettingState {}

class SettingStateError extends SettingState {
  Failure failure;
  SettingStateError({required this.failure});
}

class SettingStateLoaded extends SettingState {
  late Setting setting;
  SettingStateLoaded({required this.setting});
}
