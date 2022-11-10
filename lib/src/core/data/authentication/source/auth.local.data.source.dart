import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/failure.dart';
import '../../../domain/authentication/entities/user.dart';

@singleton
class AuthLocalDataSource {
  late SharedPreferences cache;

  AuthLocalDataSource({required this.cache});
  static const String userKey = "userKey";

  Future<UserModel>? loadUser() async {
    final data = cache.getString(userKey);
    if (data == null) throw UnAuthorizedFailure(message: "Not logged in yet!");
    return UserModel.fromJson(json.decode(data));
  }

  Future<bool>? saveUser(UserModel user) async {
    return await cache.setString(userKey, json.encode(user));
  }

  Future<bool>? removeUser() async {
    return await cache.remove(userKey);
  }
}
