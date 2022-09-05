import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/network/network.info.dart';
import '../../../../../injection.container.dart';
import '../../../domain/entities/setting.dart';
import '../../../domain/usercases/get.setting.dart' as gett;
import '../../../domain/usercases/load.setting.dart' as loadd;
import '../../../domain/usercases/set.setting.dart' as sett;

part 'setting.event.dart';
part 'setting.state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  late gett.GetSetting getSetting;
  late loadd.LoadSetting loadSetting;
  late sett.SetSetting setSetting;
  SettingBloc(
      {required this.getSetting,
      required this.setSetting,
      required this.loadSetting})
      : super(SettingStateEmpty()) {
    on<LoadSettingEvent>((event, emit) async {
      emit(SettingStateLoading());
      final result = await loadSetting(loadd.NoParams());
      if (result == null) return emit(SettingStateEmpty());
      final response = result.fold((l) => SettingStateError(failure: l),
          (r) => SettingStateLoaded(setting: r));

      if (response.runtimeType != SettingStateError) {
        emit(response);
      } else if ((await sl<NetworkInfo>().isConnected))
        add(RefreshSettingEvent());
    });
    on<GetSettingEvent>((event, emit) async {
      final result = await getSetting(gett.NoParams());
      if (result == null) return emit(SettingStateEmpty());
      final response = result.fold((l) => SettingStateError(failure: l),
          (r) => SettingStateLoaded(setting: r));
      if (response.runtimeType == SettingStateError &&
          (response as SettingStateError).failure.runtimeType ==
              NoDataFailure) {
        emit(SettingStateEmpty());
      } else {
        emit(response);
      }
    });
    on<RefreshSettingEvent>((event, emit) async {
      emit(SettingStateLoading());
      final result = await getSetting(gett.NoParams());
      if (result == null) return emit(SettingStateEmpty());
      final response = result.fold((l) => SettingStateError(failure: l),
          (r) => SettingStateLoaded(setting: r));
      if (response.runtimeType == SettingStateError &&
          (response as SettingStateError).failure.runtimeType ==
              NoDataFailure) {
        emit(SettingStateEmpty());
      } else {
        emit(response);
      }
    });
    on<SetSettingEvent>((event, emit) async {
      // emit(SignIn());
      emit(SettingStateLoading());
      final response = await setSetting(sett.Params(setting: event.setting));
      if (response == null) {
        return;
      }
      final result = response.fold((l) => SettingStateError(failure: l),
          (r) => SettingStateLoaded(setting: event.setting));
      emit(result);
    });
  }
}
