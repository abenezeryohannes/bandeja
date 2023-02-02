import 'dart:convert';

import 'package:bandeja/src/core/domain/ads/entities/ad.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/failure.dart';

@singleton
class AdLocalDataSource {
  late SharedPreferences cache;

  AdLocalDataSource({required this.cache});
  static const String adsKey = "adsKey";

  Future<List<AdModel>>? loadAds(int? page) async {
    if (page != null && page > 1) return [];
    final data = cache.getString(adsKey);
    if (data == null) throw CacheFailure();
    return loadAdsFromJson(data);
  }

  Future<bool>? saveAds(int? page, List<AdModel> ads) async {
    if (page != null && page > 1) return false;
    return await cache.setString(adsKey, json.encode(ads));
  }

  Future<List<AdModel>> loadAdsFromJson(String x) async {
    Iterable l = json.decode(x);
    return List<AdModel>.from(l.map((model) => AdModel.fromJson(model)));
  }
}
