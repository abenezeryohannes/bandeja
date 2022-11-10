import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/domain/booking/entities/padel.order.dart';
import '../../../../core/error/failure.dart';

@singleton
class BookingLocalDataSource {
  late SharedPreferences cache;

  BookingLocalDataSource({required this.cache});
  static const String bookingKey = "bookingKey";

  Future<List<PadelOrderModel>>? loadBooking(int? page) async {
    if (page != null && page > 1) return [];
    final data = cache.getString(bookingKey);
    if (data == null) throw CacheFailure();
    return loadPadelOrderFromJson(data);
  }

  Future<bool>? savePadelOrder(int? page, List<PadelOrderModel> booking) async {
    if (page != null && page > 1) return false;
    return await cache.setString(bookingKey, json.encode(booking));
  }

  Future<List<PadelOrderModel>> loadPadelOrderFromJson(String x) async {
    Iterable l = json.decode(x);
    return List<PadelOrderModel>.from(
        l.map((model) => PadelOrderModel.fromJson(model)));
  }
}
