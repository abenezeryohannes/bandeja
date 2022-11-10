import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class AdminNotificationLocalDataSource {
  late SharedPreferences cache;

  AdminNotificationLocalDataSource({required this.cache});
}
