import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/domain/authentication/entities/user.dart';
import '../../../../core/error/failure.dart';

@singleton
class AdminUsersLocalDataSource {
  late SharedPreferences cache;

  AdminUsersLocalDataSource({required this.cache});
  static const String usersKey = "adminUsersKey";

  Future<bool> saveUsers(int? page, users) async {
    if (page != null && page > 1) false;
    return await cache.setString(usersKey, json.encode(users));
  }

  Future<List<UserModel>> loadUsers(int? page) async {
    if (page != null && page > 1) return [];
    final data = cache.getString(usersKey);
    if (data == null) throw CacheFailure();
    return loadUsersFromJson((data));
  }

  Future<List<UserModel>> loadUsersFromJson(String x) async {
    Iterable l = json.decode(x);
    return List<UserModel>.from(l.map((model) => UserModel.fromJson(model)));
  }
}
