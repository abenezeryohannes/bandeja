import 'package:bandeja/firebase/admin/firebase_options.dart' as FirebaseAdmin;
import 'package:bandeja/firebase/owner/firebase_options.dart' as FirebaseOwner;
import 'package:bandeja/firebase/main/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get_storage/get_storage.dart';

import '../src/app.dart';
import '../src/core/domain/notifications/entities/notification.dart';
import '../src/core/domain/notifications/repositories/i.notification.repository.dart';
import '../src/core/presentation/widgets/app.snack.bar.dart';
import '../src/flavors.dart';
import 'injection/injector.dart';

Future<void> mainCommon() async {
  await preRunApp();
  runApp(const App());
  return FlutterNativeSplash.remove();
}

Future<void> preRunApp() async {
  // Keeps splash screen up until FlutterNativeSplash.remove is called
  FlutterNativeSplash.preserve(
    widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  );

  // Loads contents from .env into memory.
  await dotenv.load();

  // Locks app orientation
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Makes the device's app bar and bottom navigation bar visible
  // because 'flutter_native_splash.yaml' renders a full screen splash screen,
  // thereby hiding both elements
  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
  );

  //Setting SysemUIOverlay
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: true,
      systemNavigationBarColor: Colors.grey.shade100,
      systemNavigationBarDividerColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark));

  //Setting SystmeUIMode
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.top]);

  // Adds Google Font license in the app's LicenseRegistry.
  // LicenseRegistry.addLicense(() async* {
  //   final license = await rootBundle.loadString('fonts/Montserrat/OFL.txt');
  //   yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  // });

  //injections and firebase config ....
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  switch (FF.appFlavor) {
    case Flavor.owner:
      await Firebase.initializeApp(
          options: FirebaseOwner.DefaultFirebaseOptions.currentPlatform);

      break;
    case Flavor.admin:
      await Firebase.initializeApp(
          options: FirebaseAdmin.DefaultFirebaseOptions.currentPlatform);

      break;
    default:
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);
  }

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'bandeja_notifications', // id
    'High Importance Bandeja Notifications', // title
    description:
        'This channel is used for important Bandeja notifications.', // description
    importance: Importance.max,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  FirebaseMessaging.onBackgroundMessage((_firebaseMessagingBackgroundHandler));

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification == null || message.notification?.android == null) {
      return;
    }

    RemoteNotification notification = message.notification!;
    AndroidNotification android = message.notification!.android!;

    flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: android.smallIcon,
            // other properties...
          ),
        ));

    if (FF.appFlavor == Flavor.owner) {
      loadNotifications();
    }
  });
  await configureDependencies(FF.env);
  await GetStorage.init();

  // PAYMENT-INTEGRATION
  // MFSDK.init("Put API Key here", MFCountry.KUWAIT, MFEnvironment.TEST);
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (message.notification == null || message.notification?.android == null) {
    return;
  }
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'bandeja_notifications', // id
    'High Importance Bandeja Notifications', // title
    description:
        'This channel is used for important Bandeja notifications.', // description
    importance: Importance.max,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  RemoteNotification notification = message.notification!;
  AndroidNotification android = message.notification!.android!;

  flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: android.smallIcon,
          // other properties...
        ),
      ));
}

void loadNotifications() async {
  final result =
      await getIt<INotificationRepository>().getUnSeenNotifications();
  if (result == null) {
    return;
  }
  result.fold((l) {
    return;
  }, (r) {
    for (var notification in r) {
      showSnackBar(notification);
    }
  });
}

showSnackBar(NotificationModel notification) {
  AppSnackBar.warning(
      title: notification.title,
      message: notification.desc,
      icon: Image.asset(
        'assets/icons/speaker.png',
        color: Colors.grey.shade800,
        width: 24,
        height: 24,
      ),
      position: SnackPosition.TOP);

  getIt<INotificationRepository>()
      .makeNotificationSeen(notificationId: notification.id);
}
