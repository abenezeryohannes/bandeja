import 'dart:convert';

import 'package:bandeja/src/core/domain/padels/entities/padel.group.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/domain/padels/entities/padel.dart';
import '../../../../../core/domain/padels/entities/promo.code.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/fixtures/fixture.reader.dart';
import '../../../../domain/core/entities/address.dart';

@singleton
class PadelLocalDataSource {
  late SharedPreferences cache;
  PadelLocalDataSource({required this.cache});

  static const String bookmarkKey = "bookmarkKey";
  static const String featuredPadelsKey = "itemGroupsKey";

  Future<List<PadelModel>>? loadFeaturedPadels(
      int? page, AddressModel? address) async {
    if (page != null && page > 1) return [];
    final data = cache.getString(featuredPadelsKey);
    if (data == null) throw CacheFailure();
    return loadPadelsFromJson(data);
  }

  saveFeaturedPadels(
      int? page, PadelGroupModel? address, List<PadelModel> padels) async {
    if (page != null && page > 1) return [];
    return await cache.setString(
        featuredPadelsKey + (address == null ? "" : address.name),
        json.encode(padels));
  }

  Future<List<PadelModel>> loadPadelsFromJson(String x) async {
    Iterable l = json.decode(x);
    return List<PadelModel>.from(l.map((model) => PadelModel.fromJson(model)));
  }

  Future<List<PadelModel>>? loadBookmarks(int? page) async {
    if (page != null && page > 1) return [];
    final data = cache.getString(bookmarkKey);
    if (data == null) throw CacheFailure();
    return loadPadelsFromJson(data);
  }

  Future<bool> saveBookmarks(int? page, List<PadelModel> items) async {
    if (page != null && page > 1) return false;
    return await cache.setString(bookmarkKey, json.encode(items));
  }
}
