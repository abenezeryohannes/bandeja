part of 'setting.bloc.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object> get props => [];
}

class GetSettingEvent extends SettingEvent {
  GetSettingEvent();
}

class RefreshSettingEvent extends SettingEvent {
  RefreshSettingEvent();
}

class LoadSettingEvent extends SettingEvent {}

class SetSettingEvent extends SettingEvent {
  late Setting setting;
  SetSettingEvent({required this.setting});
}
