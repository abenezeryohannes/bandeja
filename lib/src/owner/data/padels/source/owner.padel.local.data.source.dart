import 'dart:convert';

import 'package:bandeja/src/core/domain/padels/entities/duration.dart';
import 'package:bandeja/src/core/domain/padels/entities/feature.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/domain/booking/entities/padel.order.dart';
import '../../../../core/domain/padels/entities/padel.dart';
import '../../../../core/domain/padels/entities/promo.code.dart';
import '../../../../core/error/failure.dart';

@singleton
class OwnerPadelLocalDataSource {
  late SharedPreferences cache;
  OwnerPadelLocalDataSource({required this.cache});

  static const String ownerBookingKey = "ownerBookingKey";
  static const String ownerPadelKey = "ownerPadelKey";
  static const String durationsKey = "durationsKey";
  static const String featuresKey = "futuresKey";
  static const String ownerPromoCodeKey = "ownerPromoCodeKey";

  saveBookings(int? page, response) async {
    if (page != null && page > 1) return false;
    return await cache.setString(ownerBookingKey, json.encode(response));
  }

  savePadels(int? page, response) async {
    if (page != null && page > 1) return false;
    return await cache.setString(ownerPadelKey, json.encode(response));
  }

  savePromoCodes(int? page, response) async {
    if (page != null && page > 1) return false;
    return await cache.setString(ownerPromoCodeKey, json.encode(response));
  }

  saveDurations(int? page, response) async {
    if (page != null && page > 1) return false;
    return await cache.setString(durationsKey, json.encode(response));
  }

  saveFeatures(int? page, response) async {
    if (page != null && page > 1) return false;
    return await cache.setString(featuresKey, json.encode(response));
  }

  loadFeatures(int? page) {
    if (page != null && page > 1) return [];
    final data = cache.getString(featuresKey);
    if (data == null) throw CacheFailure();
    return loadFeaturesFromJson(data);
  }

  loadDurations(int? page) {
    if (page != null && page > 1) return [];
    final data = cache.getString(durationsKey);
    if (data == null) throw CacheFailure();
    return loadDurationsFromJson(data);
  }

  loadBookings(int? page) async {
    if (page != null && page > 1) return [];
    final data = cache.getString(ownerBookingKey);
    if (data == null) throw CacheFailure();
    return loadPadelOrdersFromJson(data);
  }

  loadPadels(int? page) async {
    if (page != null && page > 1) return [];
    final data = cache.getString(ownerPadelKey);
    if (data == null) throw CacheFailure();
    return loadPadelsFromJson(data);
  }

  loadPromoCodes(int? page) async {
    if (page != null && page > 1) return [];
    final data = cache.getString(ownerPromoCodeKey);
    if (data == null) throw CacheFailure();
    return loadPromoCodessFromJson(data);
  }

  Future<List<PromoCodeModel>> loadPromoCodessFromJson(String x) async {
    Iterable l = json.decode(x);
    return List<PromoCodeModel>.from(
        l.map((model) => PromoCodeModel.fromJson(model)));
  }

  Future<List<FeatureModel>> loadFeaturesFromJson(String x) async {
    Iterable l = json.decode(x);
    return List<FeatureModel>.from(
        l.map((model) => FeatureModel.fromJson(model)));
  }

  Future<List<DurationModel>> loadDurationsFromJson(String x) async {
    Iterable l = json.decode(x);
    return List<DurationModel>.from(
        l.map((model) => DurationModel.fromJson(model)));
  }

  Future<List<PadelModel>> loadPadelsFromJson(String x) async {
    Iterable l = json.decode(x);
    return List<PadelModel>.from(l.map((model) => PadelModel.fromJson(model)));
  }

  Future<List<PadelOrderModel>> loadPadelOrdersFromJson(String x) async {
    Iterable l = json.decode(x);
    return List<PadelOrderModel>.from(
        l.map((model) => PadelOrderModel.fromJson(model)));
  }
}
