import 'dart:convert';

import 'package:bandeja/src/owner/data/dto/owner.monthly.stat.dto.dart';
import 'package:bandeja/src/owner/data/dto/owner.weekly.stat.dto.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/domain/booking/entities/padel.order.dart';
import '../../../../core/error/failure.dart';

@singleton
class OwnerBookingLocalDataSource {
  late SharedPreferences cache;
  OwnerBookingLocalDataSource({required this.cache});

  static const String ownerBookingKey = "ownerBookingKey";
  static const String ownerWeeklyStat = "ownerWeeklyStat";
  static const String ownerMontlyStat = "ownerMontlyStat";

  Future<bool> saveBookings(int? page, response) async {
    if (page != null && page > 1) return false;
    return await cache.setString(ownerBookingKey, json.encode(response));
  }

  Future<List<PadelOrderModel>> loadBookings(int? page) async {
    if (page != null && page > 1) return [];
    final data = cache.getString(ownerBookingKey);
    if (data == null) throw CacheFailure();
    return loadPadelOrdersFromJson(data);
  }

  Future<bool>? saveOwnerWeeklyStat(response) async {
    return await cache.setString(ownerWeeklyStat, json.encode(response));
  }

  Future<bool>? saveOwnerMontlyStat(response) async {
    return await cache.setString(ownerMontlyStat, json.encode(response));
  }

  Future<List<OwnerWeeklyStatDto>> loadOwnerWeeklyStat() {
    final data = cache.getString(ownerWeeklyStat);
    if (data == null) throw CacheFailure();
    return loadOwnerWeeklyStatFromJson(data);
  }

  Future<OwnerMonthlyStatDto> loadOwnerMontlyStat() {
    final data = cache.getString(ownerMontlyStat);
    if (data == null) throw CacheFailure();
    return loadOwnerMontlyStatFromJson(data);
  }

  Future<List<OwnerWeeklyStatDto>> loadOwnerWeeklyStatFromJson(String x) async {
    Iterable l = json.decode(x);
    return List<OwnerWeeklyStatDto>.from(
        l.map((model) => OwnerWeeklyStatDto.fromJson(model)));
  }

  Future<OwnerMonthlyStatDto> loadOwnerMontlyStatFromJson(String x) async {
    Map<String, dynamic> l = json.decode(x);
    return OwnerMonthlyStatDto.fromJson(l);
  }

  Future<List<PadelOrderModel>> loadPadelOrdersFromJson(String x) async {
    Iterable l = json.decode(x);
    return List<PadelOrderModel>.from(
        l.map((model) => PadelOrderModel.fromJson(model)));
  }
}
