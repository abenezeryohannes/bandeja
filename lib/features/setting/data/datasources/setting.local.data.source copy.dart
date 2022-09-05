import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../models/setting.model.dart';

class SettingLocalDataSource {
  late SharedPreferences sharedPreferences;
  static String SETTING_KEY = "SETTING_KEY";
  SettingLocalDataSource({required this.sharedPreferences});

  Future<bool>? addSettingToCache(SettingModel setting) async {
    return await sharedPreferences.setString(SETTING_KEY, json.encode(setting));
  }

  Future<SettingModel>? loadSetting() async {
    final cache = sharedPreferences.getString(SETTING_KEY);
    if (cache == null) {
      throw NoDataException();
    }
    Map<String, dynamic> jsonMap = json.decode(cache);
    return SettingModel.fromJson(jsonMap);
  }
}
