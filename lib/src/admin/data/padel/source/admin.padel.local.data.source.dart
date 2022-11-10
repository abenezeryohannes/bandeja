import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/domain/padels/entities/padel.dart';
import '../../../../core/error/failure.dart';

@singleton
class AdminPadelLocalDataSource {
  late SharedPreferences cache;

  AdminPadelLocalDataSource({required this.cache});
  static const String adminPadelsKey = "AdminPadelsKey";

  Future<bool> savePadels(int? page, padels) async {
    if (page != null && page > 1) false;
    return await cache.setString(adminPadelsKey, json.encode(padels));
  }

  Future<List<PadelModel>> loadPadels(int? page) async {
    if (page != null && page > 1) return [];
    final data = cache.getString(adminPadelsKey);
    if (data == null) throw CacheFailure();
    return loadPadelsFromJson((data));
  }

  Future<List<PadelModel>> loadPadelsFromJson(String x) async {
    Iterable l = json.decode(x);
    return List<PadelModel>.from(l.map((model) => PadelModel.fromJson(model)));
  }
}
