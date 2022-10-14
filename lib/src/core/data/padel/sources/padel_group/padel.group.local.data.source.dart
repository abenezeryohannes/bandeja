import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/fixtures/fixture.reader.dart';
import '../../../../domain/padels/entities/padel.group.dart';

@singleton
class PadelGroupLocalDataSource {
  late SharedPreferences cache;

  PadelGroupLocalDataSource({required this.cache});

  static const String itemGroupsKey = "padelGroupsKey";
  Future<bool>? savePadelGroups(
      int? page, List<PadelGroupModel> padelGroup) async {
    if (page != null && page > 1) return false;
    return await cache.setString(itemGroupsKey, json.encode(padelGroup));
  }

  Future<bool> savePadelGroup(PadelGroupModel padelGroup) async {
    return await cache.setString(itemGroupsKey, json.encode(padelGroup));
  }

  Future<List<PadelGroupModel>> loadPadelGroupsFromJson(String x) async {
    Iterable l = json.decode(x);
    return List<PadelGroupModel>.from(
        l.map((model) => PadelGroupModel.fromJson(model)));
  }

  Future<List<PadelGroupModel>>? loadPadelGroups(int? page) async {
    if (page != null && page > 1) return [];
    final data = cache.getString(itemGroupsKey);
    if (data == null) throw CacheFailure();
    return loadPadelGroupsFromJson(await fixture("padel.groups.json"));
  }
}
