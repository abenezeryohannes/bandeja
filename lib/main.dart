import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'core/pages/splash.screen.dart';
import 'injection.container.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/pages/home.page.dart';
import 'core/utils/setting.sp.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await injectDependencies();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);


  await Firebase.initializeApp(
    name: 'sawetapps',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //Setting SysemUIOverlay
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: true,
      systemNavigationBarColor: Colors.grey.shade200,
      systemNavigationBarDividerColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark));

//Setting SystmeUIMode
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.top]);

  runApp(MyApp(
      isFirstTime:
          await SettingSP(prefs: sl<SharedPreferences>()).getFirstTime()));
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.isFirstTime}) : super(key: key);

  final bool isFirstTime;
  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return MaterialApp(
      title: 'tasweet',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        fontFamily: 'VEXA_LIGHT',
      ),
      home: MyHomePage(title: 'tasweet', isFirstTime: isFirstTime),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.isFirstTime})
      : super(key: key);
  final String title;
  final bool isFirstTime;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    if (widget.isFirstTime) return const SplashScreen();
    return const HomePage();
  }
}
