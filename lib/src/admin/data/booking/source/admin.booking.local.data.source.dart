import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/domain/booking/entities/padel.order.dart';
import '../../../../core/error/failure.dart';
import '../dto/admin.monthly.stat.dto.dart';
import '../dto/admin.weekly.stat.dto.dart';

@singleton
class AdminBookingLocalDataSource {
  late SharedPreferences cache;

  AdminBookingLocalDataSource({required this.cache});

  static const String adminBookingKey = "adminBookingKey";
  static const String adminWeeklyStat = "adminWeeklyStat";
  static const String adminMonthlyStat = "adminMonthlyStat";

  Future<bool> saveBookings(int? page, response) async {
    if (page != null && page > 1) return false;
    return await cache.setString(adminBookingKey, json.encode(response));
  }

  Future<List<PadelOrderModel>> loadBookings(int? page) async {
    if (page != null && page > 1) return [];
    final data = cache.getString(adminBookingKey);
    if (data == null) throw CacheFailure();
    return loadPadelOrdersFromJson(data);
  }

  Future<bool>? saveAdminWeeklyStat(response) async {
    return await cache.setString(adminWeeklyStat, json.encode(response));
  }

  Future<bool>? saveAdminMonthlyStat(response) async {
    return await cache.setString(adminMonthlyStat, json.encode(response));
  }

  Future<List<AdminWeeklyStatDto>> loadAdminWeeklyStat() {
    final data = cache.getString(adminWeeklyStat);
    if (data == null) throw CacheFailure();
    return loadAdminWeeklyStatFromJson(data);
  }

  Future<AdminMonthlyStatDto> loadAdminMonthlyStat() {
    final data = cache.getString(adminMonthlyStat);
    if (data == null) throw CacheFailure();
    return loadAdminMonthlyStatFromJson(data);
  }

  Future<List<AdminWeeklyStatDto>> loadAdminWeeklyStatFromJson(String x) async {
    Iterable l = json.decode(x);
    return List<AdminWeeklyStatDto>.from(
        l.map((model) => AdminWeeklyStatDto.fromJson(model)));
  }

  Future<AdminMonthlyStatDto> loadAdminMonthlyStatFromJson(String x) async {
    Map<String, dynamic> l = json.decode(x);
    return AdminMonthlyStatDto.fromJson(l);
  }

  Future<List<PadelOrderModel>> loadPadelOrdersFromJson(String x) async {
    Iterable l = json.decode(x);
    return List<PadelOrderModel>.from(
        l.map((model) => PadelOrderModel.fromJson(model)));
  }

  // static const String userKey = "userKey";

  // Future<UserModel>? loadUser() async {
  //   final data = cache.getString(userKey);
  //   if (data == null) throw UnAuthorizedFailure(message: "Not logged in yet!");
  //   return UserModel.fromJson(json.decode(data));
  // }

  // Future<bool>? saveUser(UserModel user) async {
  //   return await cache.setString(userKey, json.encode(user));
  // }
}
