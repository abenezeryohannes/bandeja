import 'dart:convert';

import 'package:app/features/authentication/data/models/user.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';

class UserLocalDataSource {
  late SharedPreferences sharedPreferences;
  static String USER_KEY = "USER_KEY";
  UserLocalDataSource({required this.sharedPreferences});

  Future<bool>? addUserToCache(UserModel user) async {
    return await sharedPreferences.setString(USER_KEY, json.encode(user));
  }

  Future<UserModel>? loadUser() async {
    final cache = sharedPreferences.getString(USER_KEY);
    if (cache == null)
      throw NoDataException(message: "Sorry, No registered user found!");

    Map<String, dynamic> jsonMap = json.decode(cache);

    return UserModel.fromJson(jsonMap);
  }
}
