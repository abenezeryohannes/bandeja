import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotifcation {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  askPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }
}
