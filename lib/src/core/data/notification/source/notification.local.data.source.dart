import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/notifications/entities/notification.dart';
import '../../../error/failure.dart';

@singleton
class NotificationLocalDataSource {
  late SharedPreferences cache;

  NotificationLocalDataSource({required this.cache});
  static const String notificationKey = "notificationsKey";
  static const String unseenNotificationsKey = "unseenNotificationsKey";
  static const String unseenNotificationKey = "unseenNotificationKey";

  Future<List<NotificationModel>>? loadNotifications() async {
    final data = cache.getString(notificationKey);
    if (data == null) throw CacheFailure(message: "No New Notification.");
    return loadNotificationsFromJson(data);
  }

  Future<bool>? saveNotifications(
      int? page, List<NotificationModel> notifications) async {
    if (page != null && page > 1) return false;
    return await cache.setString(notificationKey, json.encode(notifications));
  }

  Future<List<NotificationModel>> loadNotificationsFromJson(String x) async {
    Iterable l = json.decode(x);
    return List<NotificationModel>.from(
        l.map((model) => NotificationModel.fromJson(model)));
  }

  Future<bool>? savetUnseenNotificationsCount(response) async {
    return await cache.setString(unseenNotificationKey, json.encode(response));
  }

  Future<int>? countUnseenNotifications() async {
    final data = cache.getString(notificationKey);
    if (data == null) return 0;
    return (int.tryParse(data) ?? 0);
  }

  Future<bool>? saveUnSeenNotifications(
      int? page, List<NotificationModel> notifications) async {
    if (page != null && page > 1) return false;
    return await cache.setString(
        unseenNotificationsKey, json.encode(notifications));
  }

  Future<List<NotificationModel>>? loadUnSeenNotifications() async {
    final data = cache.getString(unseenNotificationsKey);
    if (data == null) throw CacheFailure(message: "No New Notification.");
    return loadNotificationsFromJson(data);
  }
}
